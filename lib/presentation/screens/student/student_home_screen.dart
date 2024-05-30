import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
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
                const SizedBox(height: 16),
                _buildSubject(),
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

  Widget _buildSubject() {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      crossAxisSpacing: 15.0,
      mainAxisSpacing: 15.0,
      childAspectRatio: 1.3,
      padding: const EdgeInsets.only(bottom: 24.0),
      children: [
        _buildCivitasCard(),
        _buildCivitasCard(),
      ],
    );
  }

  Widget _buildCivitasCard() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.dark[100]!)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MenuAnchor(
              style: MenuStyle(
                elevation: WidgetStateProperty.all(0.0),
                backgroundColor: WidgetStateProperty.all(Colors.transparent),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16))),
              ),
              menuChildren: <Widget>[
                Container(
                    width: 70,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        color: AppColors.danger[500],
                        borderRadius: BorderRadius.circular(99)),
                    child: Center(
                        child: Text('Hapus',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppColors.white)))),
                Container(
                    width: 70,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        color: AppColors.secondary[500],
                        borderRadius: BorderRadius.circular(99)),
                    child: Center(
                        child: Text('Edit',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppColors.white)))),
              ],
              builder: (BuildContext context, MenuController controller,
                      Widget? child) =>
                  GestureDetector(
                onTap: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(9.33),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(color: AppColors.dark[100]!)),
                  child: Icon(
                    Iconsax.more_circle5,
                    color: AppColors.dark[500]!,
                    size: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Workshop Flutter',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text('Fulan bin Fulan',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Text _buildHeading(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
