import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:peqing/presentation/widgets/peqing_button.dart';
import 'package:peqing/route/route_names.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Sayonara",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 40,
                    ),
              ),
              Text(
                "Input Manual,",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 40,
                    ),
              ),
              const SizedBox(height: 32),
              Center(
                child: SvgPicture.asset(
                    'assets/images/onboarding_ilustration.svg'),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Text(
                    "Yuk",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 40,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  Text(
                    " Scan QR!",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 40,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                "Pencacatan nilai mahasiswa cepat hanya",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 2,
                    ),
              ),
              Text(
                "dengan Scan QR melalui gadget kamu!",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 40,
              ),
              PeqingButton(
                text: 'Mulai Sekarang',
                onPressed: () {
                  context.go(RouteNames.login);
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
