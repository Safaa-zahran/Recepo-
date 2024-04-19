import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'controller/products_provider.dart';
import 'controller/user_provider.dart';
import 'core/generated/locale_keys.g.dart';
import 'core/utils/app_config.dart';
import 'core/utils/assets_manager.dart';
import 'core/utils/colors_palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  EasyLocalization.logger.enableBuildModes = [];

  runApp(
    EasyLocalization(
      path: AssetsManager.translationsFolder,
      supportedLocales: AppConfig.supportedLocales,
      fallbackLocale: AppConfig.fallbackLocale,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, constraints, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProductsProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            ...context.localizationDelegates,
            FormBuilderLocalizations.delegate,
          ],
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateTitle: (context) => LocaleKeys.appName.tr(),
          theme: ThemeData(
            canvasColor: ColorsPalette.white,
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: ColorsPalette.primarySwatch,
            )
                .copyWith(
                  secondary: ColorsPalette.accentColor,
                )
                .copyWith(background: ColorsPalette.white),
          ),
          routes: AppConfig.routes,
        ),
      );
    }));
  }
}
