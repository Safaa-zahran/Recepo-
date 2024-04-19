import 'package:flutter/material.dart';

import '../../core/utils/assets_manager.dart';

class AnimatedSplash extends StatefulWidget {
  @override
  _AnimatedSplashState createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplash>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _logoAnimation;

  @override
  void initState() {
    super.initState();

    // تعريف مراقب الأنيميشن
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    // تعريف الأنيميشن المطبق على الشعار
    _logoAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );

    // بدء تشغيل الأنيميشن
    _animationController!.forward();

    // تأخير ثواني قبل التنقل إلى شاشة تسجيل الدخول
    // Future.delayed(Duration(seconds: 3), () {
    //   Navigator.pushReplacementNamed(context, SignInForm.routeName);
    // });
  }

  @override
  void dispose() {
    // إيقاف مراقب الأنيميشن عند إغلاق الشاشة
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            FadeTransition(
                opacity: _logoAnimation!,
                child: Center(child: Image.asset(AssetsManager.splash))),
          ]),
        ),
      ),
    );
  }
}
