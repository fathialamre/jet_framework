import 'package:jet_app/app/resources/languages/ar.dart';
import 'package:jet_app/app/resources/languages/en.dart';
import 'package:jet_framework/resources/languages/jet_translations.dart';

class AppTranslations implements JetTranslations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': ar,
        'en': en,
      };
}
