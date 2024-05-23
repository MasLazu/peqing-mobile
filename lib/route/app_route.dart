import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:peqing/presentation/screens/lecturer/lecturer_home_page.dart';
import 'package:peqing/presentation/screens/lecturer/lecturer_scan_page.dart';
import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/data/models/user.dart';
import 'package:peqing/presentation/screens/admin/admin_home_screen.dart';
import 'package:peqing/presentation/screens/login_screen.dart';
import 'package:peqing/presentation/screens/onboarding_screen.dart';
import 'package:peqing/presentation/screens/splash_screen.dart';

import 'package:peqing/route/route_names.dart';

GoRouter appRoute = GoRouter(
  initialLocation: RouteNames.lecturerHome,
  routes: [
    GoRoute(
      path: RouteNames.root,
      redirect: _initialRedirect,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: RouteNames.onBoarding,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: _fadeTransition,
        child: const OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: RouteNames.login,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: RouteNames.adminHome,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const AdminHomeScreen(),
      ),
    ),
    GoRoute(
      path: RouteNames.lecturerHome,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        transitionsBuilder: _fadeTransition,
        child: const LecturerHomePage()
      ),
    ),
    GoRoute(
      path: RouteNames.lecturerScanQR,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: _fadeTransition,
        child: const LecturerScanPage()
      ),
    ),
    GoRoute(
      path: RouteNames.studentHome,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const Scaffold(
          body: Center(
            child: Text('Student Home'),
          ),
        ),
      ),
    ),
  ],
);

Widget _fadeTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(
    opacity: animation,
    child: child,
  );
}

Future<String?> _initialRedirect(
    BuildContext context, GoRouterState state) async {
  final authBloc = BlocProvider.of<AuthBloc>(context);

  if (authBloc.state is Authenticated) {
    var state = authBloc.state as Authenticated;
    switch (state.auth.user.role) {
      case Role.admin:
        return RouteNames.adminHome;
      case Role.lecturer:
        return RouteNames.lecturerHome;
      case Role.student:
        return RouteNames.studentHome;
      default:
        throw Exception('Unknown role: ${state.auth.user.role}');
    }
  }
  return null;
}
