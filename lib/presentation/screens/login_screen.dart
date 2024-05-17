import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/core/theme/app_theme.dart';
import 'package:peqing/data/models/user.dart';
import 'package:peqing/route/route_names.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.danger[500],
            ),
          );
        }

        if (state is Authenticated) {
          switch (state.auth.user.role) {
            case Role.admin:
              context.go(RouteNames.adminHome);
              break;
            case Role.lecturer:
              context.go(RouteNames.lecturerHome);
              break;
            case Role.student:
              context.go(RouteNames.studentHome);
              break;
            default:
              throw Exception('Unknown role: ${state.auth.user.role}');
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 24.0, right: 24.0, top: 60.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset('assets/icons/peqing-logo.png', height: 48.0),
                    const SizedBox(height: 40.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Yuk ',
                          style: Theme.of(context).textTheme.headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Login!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Masukkan email & password buat login!',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      'NRP / NIP',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Masukkan email',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Password',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Masukkan password',
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                            const LoginAuth(id: 'admin', password: 'admin'));
                      },
                      child: state is AuthLoading
                          ? const SizedBox(
                              height: 18.0,
                              width: 18.0,
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : Text('Login', style: AppTheme.buttonTextStyle),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
