import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:peqing/presentation/screens/lecturer/lecturer_home_page.dart';
import 'package:peqing/presentation/screens/lecturer/lecturer_scan_page.dart';
import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/data/models/users/lecturer.dart';
import 'package:peqing/data/models/users/student.dart';
import 'package:peqing/data/models/users/user.dart';
import 'package:peqing/presentation/screens/admin/admin_civitas_screen.dart';
import 'package:peqing/presentation/screens/admin/admin_history_screen.dart';
import 'package:peqing/presentation/screens/admin/admin_home_screen.dart';
import 'package:peqing/presentation/screens/admin/admin_profile_screen.dart';
import 'package:peqing/presentation/screens/login_screen.dart';
import 'package:peqing/presentation/screens/onboarding_screen.dart';
import 'package:peqing/presentation/screens/splash_screen.dart';
import 'package:peqing/presentation/widgets/navbar/admin_navbar.dart';

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
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) =>
          AdminNavbar(page: child, state: state),
      routes: [
        GoRoute(
          path: RouteNames.adminHome,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            transitionsBuilder: _fadeTransition,
            child: const AdminHomeScreen(),
          ),
        ),
        GoRoute(
          path: RouteNames.adminCivitas,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            transitionsBuilder: _fadeTransition,
            child: const AdminCivitasScreen(),
          ),
        ),
        GoRoute(
          path: RouteNames.adminHistory,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            transitionsBuilder: _fadeTransition,
            child: const AdminHistoryScreen(),
          ),
        ),
        GoRoute(
          path: RouteNames.adminProfile,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            transitionsBuilder: _fadeTransition,
            child: const AdminProfileScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: RouteNames.lecturerHome,
      pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionsBuilder: _fadeTransition,
          child: const LecturerHomePage()),
    ),
    GoRoute(
      path: RouteNames.lecturerScanQR,
      pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionsBuilder: _fadeTransition,
          child: const LecturerScanPage()),
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
    User user = state.auth.user;

    if (user is Lecturer) {
      return RouteNames.lecturerHome;
    } else if (user is Student) {
      return RouteNames.studentHome;
    } else {
      return RouteNames.adminHome;
    }
  }
  return null;
}
