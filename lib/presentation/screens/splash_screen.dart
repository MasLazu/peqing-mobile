import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peqing/route/route_names.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _initiaRedirect(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    context.go(RouteNames.onBoarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset('assets/images/logo-splash.png'),
        ),
      ),
    );
  }
}
