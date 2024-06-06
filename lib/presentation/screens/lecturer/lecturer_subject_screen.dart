import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/bloc/suject/subject_bloc.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/data/models/subject.dart';
import 'package:peqing/presentation/widgets/appbars/root_appbar.dart';

class LecturerSubjectScreen extends StatefulWidget {
  const LecturerSubjectScreen({super.key});

  @override
  State<LecturerSubjectScreen> createState() => LecturerSubjectScreenState();
}

class LecturerSubjectScreenState extends State<LecturerSubjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RootAppbar(title: 'Mata Kuliah', context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: BlocConsumer<SubjectBloc, SubjectState>(
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
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<SubjectBloc>().add(LoadSubject());
                  },
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                    childAspectRatio: 1.2,
                    padding: const EdgeInsets.only(bottom: 24.0),
                    children: [
                      for (Subject subject in state is SubjectLoaded
                          ? state.subjects
                          : (state as SubjectLoading).subjects!)
                        _buildCivitasCard(subject),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCivitasCard(Subject subject) {
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
}
