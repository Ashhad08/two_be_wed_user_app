import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/navigation_helper.dart';
import '../home_view/home_view.dart';
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
    _checkUserLogin();
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

  _checkUserLogin() {
    Timer(const Duration(seconds: 3), () async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        NavigationHelper.pushReplacement(
          context,
          HomeView(),
        );
      } else {
        NavigationHelper.pushReplacement(
          context,
          const UserAuthView(),
        );
      }
    });
  }
}
