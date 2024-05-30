import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/core/constant/constant.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/presentation/widgets/appbars/welcome_appbar.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WelcomeAppbar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeading('QR Profile Kamu'),
                const SizedBox(height: 16),
                _buildQRCode(context),
                const SizedBox(height: 16),
                _buildHeading('Mata Kuliah Kamu'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQRCode(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.dark[100]!, width: 1.0),
          ),
          child: Column(
            children: [
              Image.network(
                '${Constant.backendDomain}/static/${(state as AuthStudent).data.id}.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ],
          ),
        );
      },
    );
  }

  Text _buildHeading(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
