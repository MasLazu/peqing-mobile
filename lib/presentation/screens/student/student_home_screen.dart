import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/bloc/suject/subject_bloc.dart';
import 'package:peqing/core/constant/constant.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/data/models/subject.dart';
import 'package:peqing/presentation/widgets/appbars/welcome_appbar.dart';
import 'package:peqing/route/route_names.dart';

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
    return BlocConsumer<SubjectBloc, SubjectState>(
      listener: (context, state) {
        if (state is SubjectError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.danger[500]!,
              content: Text(state.message),
            ),
          );
        }
        if (state is SubjectLoaded && state.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.primary[400]!,
              content: Text(state.message!),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is SubjectLoaded ||
            (state is SubjectLoading && state.subjects != null)) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<SubjectBloc>().add(LoadSubject());
            },
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 15.0,
              childAspectRatio: 1.1,
              padding: const EdgeInsets.only(bottom: 24.0),
              children: [
                for (Subject subject in state is SubjectLoaded
                    ? state.subjects.take(2)
                    : (state as SubjectLoading).subjects?.take(2) ?? [])
                  _buildSubjectCard(subject),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildSubjectCard(Subject subject) {
    return GestureDetector(
      onTap: () {
        context.push('${RouteNames.studentDetailSubject}/${subject.id}');
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.dark[100]!)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: AppColors.dark[500]!,
                  borderRadius: BorderRadius.circular(99)),
              child: const Icon(
                Iconsax.clipboard_text5,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(subject.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(subject.lecturer!.user!.name,
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
