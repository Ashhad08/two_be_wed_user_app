import 'dart:async';

import 'package:flutter/material.dart';

import '../../../utils/navigation_helper.dart';
import '../user_auth_view/user_auth_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _checkAdminLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        "assets/images/app_logo.png",
        scale: 1,
      )),
    );
  }

  _checkAdminLogin() {
    Timer(const Duration(seconds: 3), () async {
      NavigationHelper.pushReplacement(context, const UserAuthView());
    });
  }
}
