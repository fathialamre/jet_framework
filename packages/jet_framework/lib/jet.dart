import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:jet_framework/exceptions/jet_error.dart';
import 'package:jet_framework/helpers/helper.dart';
import 'package:jet_framework/helpers/jet_error_stack.dart';
import 'package:jet_framework/networking/jet_service.dart';
import 'package:jet_framework/resources/languages/jet_local.dart';
import 'package:jet_framework/resources/languages/jet_translations.dart';
import 'package:jet_framework/router/models/jet_page.dart';
import 'package:jet_framework/theme/jet_style.dart';
import 'exceptions/jet_exception_handler.dart';
import 'helpers/jet_storage.dart';

class Jet {
  String _name = 'Jet Framework';

  String? _authSessionKey;

  String? _loginRoute;
  JetStyle _style = JetStyle();

  bool _shouldUserBaseResponse = true;

  JetErrorHandler _errorHandler = JetErrorHandler();
  final List<JetPage> _pages = [];

  final List<JetLocale> _supportedLocales = [
    JetLocale('English', Locale('en')),
    JetLocale('العربية', Locale('ar')),
  ];
  final List<JetService> _apiServices = [];

  JetTranslations? _jetTranslations;

  bool shouldUseErrorStack = false;

  static Future<Jet> fly({
    Future<Jet> Function()? setup,
    Future<void> Function(Jet jet)? setupFinished,
  }) async {
    const String envFile = String.fromEnvironment(
      'ENV_FILE',
      defaultValue: '.env',
    );

    await dotenv.load(fileName: envFile);

    final jetApp = setup != null ? await setup() : Jet();

    if (jetApp.shouldUseErrorStack) {
      JetErrorStack.init();
    }

    await JetStorage.init();

    if (setupFinished != null) {
      await setupFinished(jetApp);
    }

    return jetApp;
  }

  setName(String name) => _name = name;

  String get name => _name.tr;

  enableErrorStack() {
    shouldUseErrorStack = true;
  }

  disableErrorStack() {
    shouldUseErrorStack = false;
  }

  addService(JetService service) {
    _apiServices.add(service);
  }

  addManyServices(List<JetService> services) {
    _apiServices.addAll(services);
  }

  List<JetService>? get apiServices => _apiServices;

  JetService get apiService {
    if (_apiServices.isEmpty) {
      throw JetError('No services found, please add services to Jet');
    }

    return _apiServices.firstWhere((service) => service.isGlobal, orElse: () {
      throw JetError('No global service found, please add a global service');
    });
  }

  final JetDecoder _apiDecoders = {};

  JetDecoder get apiDecoders => _apiDecoders;

  Map<Type, dynamic> get home => {
        String: 'home',
      };

  addDecoder(Map<Type, dynamic> decoders) {
    _apiDecoders.addAll(decoders);
  }

  addPage(JetPage page) {
    _pages.add(page);
  }

  addPages(List<JetPage> pages) {
    _pages.addAll(pages);
  }

  List<JetPage> get pages => _pages;

  addStyle(JetStyle style) {
    _style = style;
  }

  JetStyle get style => _style;

  setTranslations(JetTranslations translations) {
    _jetTranslations = translations;
  }

  JetTranslations get translations {
    if (_jetTranslations == null) {
      throw JetError('No translations found, please add translations to Jet');
    }
    return _jetTranslations!;
  }

  addLocale(JetLocale locale) {
    if (_supportedLocales.contains(locale)) {
      throw JetError('Locale already exists');
    }
    _supportedLocales.add(locale);
  }

  List<JetLocale> get supportedLocales => _supportedLocales;

  Locale getLocal() {
    final String? countryCode = JetStorage.read(key: 'local');
    if (countryCode != null) {
      return Locale(countryCode);
    }
    return getEnvLocal();
  }

  String get countryCode => JetStorage.read(key: 'local') ?? 'en';

  addAuthSessionKey(String key) {
    _authSessionKey = key;
  }

  String get authKey {
    if (_authSessionKey == null) {
      throw JetError('No auth key found, please add an auth key to Jet');
    }
    return _authSessionKey!;
  }

  addLoginRoute(String route) {
    _loginRoute = route;
  }

  String get loginRoute {
    if (_loginRoute == null) {
      throw JetError('No login route found, please add a login route to Jet');
    }
    return _loginRoute!;
  }

  String get initialRoute {
    if (pages.isEmpty) {
      throw JetError(
          'No pages found. Please add pages or configure a navigation hub in the Jet instance.');
    }

    return pages
        .firstWhere(
          (page) => page.initial,
          orElse: () => throw JetError('No initial page defined.'),
        )
        .name;
  }

  setBaseResponse(bool value) {
    _shouldUserBaseResponse = value;
  }

  bool get useBaseResponse => _shouldUserBaseResponse;

  setErrorHandler(JetErrorHandler handler) {
    _errorHandler = handler;
  }

  JetErrorHandler get errorHandler => _errorHandler;
}
