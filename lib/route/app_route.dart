import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:peqing/presentation/screens/lecturer/lecturer_home_page.dart';
import 'package:peqing/presentation/screens/login_screen.dart';
import 'package:peqing/presentation/screens/splash_screen.dart';
import 'package:peqing/route/route_names.dart';

GoRouter appRoute = GoRouter(
  initialLocation: RouteNames.lecturerHome,
  routes: [
    GoRoute(
      path: RouteNames.root,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: RouteNames.login,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: _fadeTransition,
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: RouteNames.adminHome,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: _fadeTransition,
        child: const Center(
          child: Text('Admin Home'),
        ),
      ),
    ),
    GoRoute(
      path: RouteNames.lecturerHome,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: _fadeTransition,
        child: const LecturerHomePage()
      ),
    ),
    GoRoute(
      path: RouteNames.studentHome,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: _fadeTransition,
        child: const Center(
          child: Text('Student Home'),
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
