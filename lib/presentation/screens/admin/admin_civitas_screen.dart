import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/bloc/lecturer/lecturer_bloc.dart';
import 'package:peqing/bloc/student/student_bloc.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/data/models/lecturer.dart';
import 'package:peqing/data/models/role.dart';
import 'package:peqing/data/models/student.dart';
import 'package:peqing/presentation/widgets/appbars/root_appbar.dart';
import 'package:peqing/presentation/widgets/sheets/civitas_form.dart';

class AdminCivitasScreen extends StatefulWidget {
  const AdminCivitasScreen({super.key});

  @override
  State<AdminCivitasScreen> createState() => _AdminCivitasScreenState();
}

class _AdminCivitasScreenState extends State<AdminCivitasScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: RootAppbar(
          title: 'Daftar Civitas PENS',
          context: context,
          bottom: _buidTabBar(),
        ),
        body: TabBarView(
          children: [
            _buildDataDosen(),
            _buildDataMahasiswa(),
          ],
        ),
      ),
    );
  }

  Widget _buildDataDosen() {
    return Padding(
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
          BlocConsumer<LecturerBloc, LecturerState>(listener: (context, state) {
            if (state is LecturerError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.danger[500]!,
                  content: Text(state.message),
                ),
              );
            }
            if (state is LecturerLoaded && state.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.primary[400]!,
                  content: Text(state.message!),
                ),
              );
            }
          }, builder: (context, state) {
            if (state is LecturerLoaded ||
                (state is LecturerLoading && state.lecturers != null)) {
              return Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {
                  context.read<LecturerBloc>().add(LoadLecturer());
                },
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                  padding: const EdgeInsets.only(bottom: 24.0),
                  children: [
                    for (Lecturer lecturer in state is LecturerLoaded
                        ? state.lecturers
                        : (state as LecturerLoading).lecturers!)
                      _buildCivitasCard(lecturer),
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
    );
  }

  Widget _buildDataMahasiswa() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Cari nama mahasiswa',
            ),
          ),
          const SizedBox(height: 24.0),
          BlocConsumer<StudentBloc, StudentState>(listener: (context, state) {
            if (state is StudentError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.danger[500]!,
                  content: Text(state.message),
                ),
              );
            }
            if (state is StudentLoaded && state.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.primary[400]!,
                  content: Text(state.message!),
                ),
              );
            }
          }, builder: (context, state) {
            if (state is StudentLoaded ||
                (state is StudentLoading && state.students != null)) {
              return Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {
                  context.read<StudentBloc>().add(LoadStudent());
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                    padding: const EdgeInsets.only(bottom: 24.0),
                    children: [
                      for (Student student in state is StudentLoaded
                          ? state.students
                          : (state as StudentLoading).students!)
                        _buildCivitasCard(student),
                    ],
                  ),
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
    );
  }

  Widget _buildCivitasCard(Role user) {
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
                    Iconsax.profile_tick5,
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
                        if (user is Lecturer) {
                          context
                              .read<LecturerBloc>()
                              .add(DeleteLecturer(user.id!));
                        }
                        if (user is Student) {
                          context
                              .read<StudentBloc>()
                              .add(DeleteStudent(user.id!));
                        }
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
                        showCivitasForm(context, data: user);
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
            Text(user.user!.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(user.user!.email!,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buidTabBar() {
    return Builder(builder: (context) {
      return TabBar(
        indicatorSize: TabBarIndicatorSize.values[0],
        tabs: const [
          Tab(child: Text('Data Dosen')),
          Tab(child: Text('Data Mahasiswa')),
        ],
      );
    });
  }
}
