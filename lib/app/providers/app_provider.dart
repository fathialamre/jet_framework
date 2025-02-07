import 'package:jet_app/app/config/decoders.dart';
import 'package:jet_app/app/design/style.dart';
import 'package:jet_app/app/resources/languages/translations.dart';
import 'package:jet_framework/jet.dart';
import 'package:jet_framework/providers/jet_provider.dart';
class AppProvider implements JetProvider {
  @override
  Future<Jet?> boot(Jet jet) async {
    jet.enableErrorStack();
    jet.addDecoder(apiDecoders);
    jet.addLoginRoute('/login');
    jet.addAuthSessionKey('auth');
    jet.setTranslations(AppTranslations());
    jet.addStyle(AppStyle());
    return jet;
  }

  @override
  Future<void> afterBoot(Jet jet) async {}
}

