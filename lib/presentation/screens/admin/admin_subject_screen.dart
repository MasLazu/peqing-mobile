import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/bloc/suject/subject_bloc.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/data/models/subject.dart';
import 'package:peqing/presentation/widgets/appbars/root_appbar.dart';

class AdminSubjectScreen extends StatefulWidget {
  const AdminSubjectScreen({super.key});

  @override
  State<AdminSubjectScreen> createState() => _AdminSubjectScreenState();
}

class _AdminSubjectScreenState extends State<AdminSubjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RootAppbar(title: 'Daftar Matakuliah PENS', context: context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Cari nama dosen',
                ),
              ),
              const SizedBox(height: 24.0),
              BlocConsumer<SubjectBloc, SubjectState>(
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
              }, builder: (context, state) {
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
                      padding: const EdgeInsets.only(bottom: 24.0),
                      children: [
                        for (Subject subject in state is SubjectLoaded
                            ? state.subjects
                            : (state as SubjectLoading).subjects!)
                          _buildCivitasCard(subject),
                      ],
                    ),
                  ));
                }
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
            ],
          ),
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
            Row(
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
                const Spacer(),
                MenuAnchor(
                  style: MenuStyle(
                    elevation: WidgetStateProperty.all(0.0),
                    backgroundColor:
                        WidgetStateProperty.all(Colors.transparent),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                  ),
                  menuChildren: <Widget>[
                    GestureDetector(
                      onTap: () {
                        context
                            .read<SubjectBloc>()
                            .add(DeleteSubject(subject.id!));
                      },
                      child: Container(
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
                    ),
                    GestureDetector(
                      onTap: () {
                        // showCivitasForm(context, data: user);
                      },
                      child: Container(
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
                    ),
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
              ],
            ),
            const SizedBox(height: 24.0),
            Text(subject.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(subject.lecturer!.user.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
