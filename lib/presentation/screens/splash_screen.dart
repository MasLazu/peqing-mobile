// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/data/models/user.dart';
import 'package:peqing/route/route_names.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _initiaRedirect(BuildContext context) async {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    if (authBloc.state is Authenticated) {
      var state = authBloc.state as Authenticated;
      switch (state.auth.user.role) {
        case Role.admin:
          return context.go(RouteNames.adminHome);
        case Role.lecturer:
          return context.go(RouteNames.lecturerHome);
        case Role.student:
          return context.go(RouteNames.studentHome);
        default:
          throw Exception('Unknown role: ${state.auth.user.role}');
      }
    }

    await Future.delayed(const Duration(seconds: 2));
    context.go(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    _initiaRedirect(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset('assets/images/logo-splash.png'),
        ),
      ),
    );
  }
}
