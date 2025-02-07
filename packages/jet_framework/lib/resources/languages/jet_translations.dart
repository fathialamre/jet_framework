import 'package:get/get.dart';

typedef JetTranslations = Translations;

class JetLocalTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => defaultKeys;

  Map<String, Map<String, String>> defaultKeys = {
    'ar': {
      'Light': 'الوضع الفاتح',
      'Dark': 'الوضع الداكن',
      'Select Language': 'اختر اللغة',
      'Submit': 'إرسال',
      'Login': 'تسجيل الدخول',
      'Logout': 'تسجيل الخروج',
      'Theme': 'السمة',
      'Language': 'اللغة',
      'App Language': 'لغة التطبيق',
      'Display Options': 'خيارات العرض',
      'Are you sure you want to logout?': 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
      'No': 'لا',
      'Yes': 'نعم',
      'Jet Framework': 'إطار جت',
    },
    'en': {
      'Light': 'Light',
      'Dark': 'Dark',
      'Select Language': 'Select Language',
      'Submit': 'Submit',
      'Login': 'Login',
      'Logout': 'Logout',
      'Theme': 'Theme',
      'Language': 'Language',
      'App Language': 'App Language',
      'Display Options': 'Display Options',
      'Are you sure you want to logout?': 'Are you sure you want to logout?',
      'No': 'No',
      'Yes': 'Yes',
      'Jet Framework': 'Jet Framework',
    },
  };
}
