import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'controller/products_provider.dart';
import 'controller/user_provider.dart';
import 'core/generated/locale_keys.g.dart';
import 'core/utils/app_config.dart';
import 'core/utils/colors_palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
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
          onGenerateTitle: (context) => LocaleKeys.appName,
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
