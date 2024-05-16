import 'package:flutter/material.dart';
import 'package:peqing/presentation/widgets/peqing_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset('assets/icons/peqing-logo.png', height: 48.0),
                const SizedBox(height: 40.0),
                Text(
                  'Yuk Login!',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Masukkan email & password buat login!',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24.0),
                Text(
                  'Email',
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
                PeqingButton(text: 'Login', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
