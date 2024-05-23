import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/presentation/widgets/peqing_button.dart';
import 'package:go_router/go_router.dart';
import 'package:peqing/route/route_names.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Admin Home Screen"),
              const SizedBox(height: 24),
              PeqingButton(
                  text: 'Logout',
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(const LogoutAuth());
                    context.go(RouteNames.login);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
