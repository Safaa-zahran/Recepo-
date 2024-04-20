import 'package:flutter/material.dart';
import 'package:posts_app/view/screens/SignInForm.dart';
import 'package:posts_app/view/screens/SignUpForm.dart';
import 'package:posts_app/view/screens/add_product_screen.dart';
import 'package:posts_app/view/screens/products_screen.dart';

import '../../view/screens/edit_product_screen.dart';
import '../../view/screens/splash_screen.dart';

class AppConfig {
  static const String appName = 'Recepo';

  static Map<String, Widget Function(BuildContext)> routes = {
    SplashScreen.routeName: (_) => const SplashScreen(),
    ProductsScreen.routeName: (_) => const ProductsScreen(),
    SignInForm.routeName: (_) => SignInForm(),
    SignUpForm.routeName: (_) => SignUpForm(),
    AddProductScreen.routeName: (_) => const AddProductScreen(),
    EditProductScreen.routeName: (_) => const EditProductScreen(),
  };
}
