import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/data/models/user.dart';
import 'package:peqing/presentation/screens/login_screen.dart';
import 'package:peqing/route/route_names.dart';

GoRouter appRoute = GoRouter(
  initialLocation: RouteNames.root,
  routes: [
    GoRoute(
      path: RouteNames.root,
      redirect: _initiaRedirect,
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
        child: const Center(
          child: Text('Admin Home'),
        ),
      ),
    ),
    GoRoute(
      path: RouteNames.lecturerHome,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const Center(
          child: Text('Lecturer Home'),
        ),
      ),
    ),
    GoRoute(
      path: RouteNames.studentHome,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const Center(
          child: Text('Student Home'),
        ),
      ),
    ),
  ],
);

String _initiaRedirect(BuildContext context, GoRouterState state) {
  final authBloc = BlocProvider.of<AuthBloc>(context);
  if (authBloc.state is Notauthenticated) return RouteNames.login;
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
