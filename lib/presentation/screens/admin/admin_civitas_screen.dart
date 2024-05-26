import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/bloc/lecturer/lecturer_bloc.dart';
import 'package:peqing/bloc/student/student_bloc.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/data/models/users/lecturer.dart';
import 'package:peqing/data/models/users/student.dart';
import 'package:peqing/presentation/widgets/appbars/root_appbar.dart';

class AdminCivitasScreen extends StatefulWidget {
  const AdminCivitasScreen({super.key});

  @override
  State<AdminCivitasScreen> createState() => _AdminCivitasScreenState();
}

class _AdminCivitasScreenState extends State<AdminCivitasScreen> {
  final List<Map<String, String>> students = [
    {
      'name': 'Fulan bin Fulan',
      'title': 'Mahasiswa Teknik Informatika',
    },
    {
      'name': 'Fulan bin Fulan',
      'title': 'Mahasiswa Teknik Informatika',
    },
    {
      'name': 'Fulan bin Fulan',
      'title': 'Mahasiswa Teknik Informatika',
    },
    {
      'name': 'Fulan bin Fulan',
      'title': 'Mahasiswa Teknik Informatika',
    },
    {
      'name': 'Fulan bin Fulan',
      'title': 'Mahasiswa Teknik Informatika',
    },
  ];

  final List<Map<String, String>> lecturers = [
    {
      'name': 'Fulan bin Fulan, S.Kom., M.Kom.',
      'title': 'Dosen Teknik Informatika',
    },
    {
      'name': 'Fulan bin Fulan, S.Kom., M.Kom.',
      'title': 'Dosen Teknik Informatika',
    },
    {
      'name': 'Fulan bin Fulan, S.Kom., M.Kom.',
      'title': 'Dosen Teknik Informatika',
    },
  ];

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
          BlocConsumer<LecturerBloc, LecturerState>(
            listener: (context, state) {
              if (state is LecturerError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.danger[500]!,
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) => Expanded(
              child: state is LecturerLoaded
                  ? RefreshIndicator(
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
                          for (Lecturer lecturer in state.lecturers)
                            _buildCivitasCard(
                              name: lecturer.name,
                              title: lecturer.nip,
                            ),
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
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
          BlocConsumer<StudentBloc, StudentState>(
            listener: (context, state) {
              if (state is StudentError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.danger[500]!,
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) => Expanded(
              child: state is StudentLoaded
                  ? RefreshIndicator(
                      onRefresh: () async {
                        context.read<StudentBloc>().add(LoadStudent());
                      },
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 15.0,
                        padding: const EdgeInsets.only(bottom: 24.0),
                        children: [
                          for (Student student in state.students)
                            _buildCivitasCard(
                              name: student.name,
                              title: student.major,
                            ),
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCivitasCard({required String name, required String title}) {
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
                Container(
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
              ],
            ),
            const SizedBox(height: 24.0),
            Text(name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(title,
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
