import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jet_framework/bindings/jet_injector.dart';
import 'package:jet_framework/jet.dart';
import 'package:jet_framework/resources/languages/jet_translations.dart';

class JetMain extends StatelessWidget {
  const JetMain({
    super.key,
    required this.jet,
  });

  final Jet jet;

  @override
  Widget build(BuildContext context) {
    final style = jet.style;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? widget) {
        return GetMaterialApp(
          builder: (context, widget) {
            ScreenUtil.init(context);
            return MediaQuery(
              data: MediaQuery.of(context),
              child: widget!,
            );
          },
          title: 'Jet',
          initialRoute: jet.initialRoute,
          locale: jet.getLocal(),
          fallbackLocale: const Locale('en'),
          translations: getTrans(),
          getPages: jet.pages,
          theme: style.theme.light,
          darkTheme: style.theme.dark,
          themeMode: style.getThemeMode,
          initialBinding: bindingsBuilder(
            [
              () => singletonPut(jet),
            ],
          ),
        );
      },
    );
  }

  JetLocalTranslations getTrans() {
    final tr = JetLocalTranslations();

    jet.translations.keys.forEach((key, value) {
      tr.defaultKeys.update(key, (existing) => existing..addAll(value),
          ifAbsent: () => value);
    });

    return tr;
  }
}
