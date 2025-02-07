import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jet_framework/bindings/jet_injector.dart';
import 'package:jet_framework/helpers/extensions/text_extensions.dart';
import 'package:jet_framework/helpers/jet_storage.dart';
import 'package:jet_framework/router/jet_router.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  RxString get currentLanguage => JetApp.countryCode.obs;

  static showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      builder: (context) {
        final supportedLocales = JetApp.supportedLocales;
        final currentLanguage = Get.locale?.languageCode;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Wrap(
              children: [
                Center(
                    child: Text(
                  'App Language'.tr,
                ).titleSmall(context)),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Divider(),
                ),
                ...supportedLocales
                    .map(
                      (jetLocale) => ListTile(
                        trailing: Icon(
                          Icons.check_circle,
                          color: jetLocale.locale.languageCode == currentLanguage
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).disabledColor,
                        ),
                        title: Text(
                          jetLocale.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ).labelMedium(context),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        visualDensity: VisualDensity.compact,
                        onTap: () async {
                          routeBack();
                          await Get.updateLocale(jetLocale.locale);
                          await JetStorage.write(
                            key: 'local',
                            value: jetLocale.locale.languageCode,
                          );
                        },
                      ),
                    )

              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButton<String>(
        value: currentLanguage.value,
        items: JetApp.supportedLocales.map((jetLocale) {
          return DropdownMenuItem(
            value: jetLocale.locale.languageCode,
            child: Text(
              jetLocale.label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }).toList(),
        onChanged: (String? newLanguageCode) async {
          if (newLanguageCode != null) {
            await Get.updateLocale(Locale(newLanguageCode));
            await JetStorage.write(
              key: 'local',
              value: newLanguageCode,
            );

            currentLanguage.value = newLanguageCode;
          }
        },
      ),
    );
  }
}
