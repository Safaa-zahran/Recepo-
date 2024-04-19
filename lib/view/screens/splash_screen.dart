import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:posts_app/view/screens/SignInForm.dart';
import 'package:posts_app/view/screens/products_screen.dart';

import '../../core/services/secure_storage/secure_storage_keys.dart.dart';
import '../../core/services/secure_storage/secure_storage_service.dart';
import '../../core/utils/assets_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _route() async {
    final token = SecureStorageService.instance
        .readString(key: SecureStorageKeys.token)
        .toString();
    if (token == null || token.isEmpty) {
      Navigator.pushNamed(context, SignInForm.routeName);
    } else {
      Navigator.pushNamed(context, ProductsScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final token = SecureStorageService.instance
        .readString(key: SecureStorageKeys.token)
        .toString();
    return AnimatedSplashScreen(
      splash: Center(child: Image.asset(AssetsManager.splash)),
      nextScreen: token.isEmpty ? SignInForm() : ProductsScreen(),
      splashTransition: SplashTransition.fadeTransition,
      // pageTransitionType: PageTransitionType.scale,
      backgroundColor: Colors.white,
    );
  }
}
