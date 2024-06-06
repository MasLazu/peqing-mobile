import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/data/models/grade_type.dart';
import 'package:peqing/data/models/student.dart';
import 'package:peqing/data/models/subject.dart';
import 'package:peqing/data/repositories/grade_repository.dart';
import 'package:peqing/data/repositories/grade_type_repository.dart';
import 'package:peqing/data/repositories/student_repository.dart';
import 'package:peqing/data/repositories/subject_repository.dart';
import 'package:peqing/presentation/widgets/buttons/peqing_button.dart';
import 'package:peqing/presentation/widgets/peqing_appbar.dart';
import 'package:peqing/presentation/widgets/peqing_textfield.dart';
import 'package:peqing/route/route_names.dart';

class LecturerAddGradePage extends StatefulWidget {
  final int studentId;
  const LecturerAddGradePage({super.key, required this.studentId});

  @override
  State<LecturerAddGradePage> createState() => _LecturerAddGradePageState();
}

class _LecturerAddGradePageState extends State<LecturerAddGradePage> {
  late Student student;
  bool isLoading = true;
  bool isSubmitting = false;
  Subject? subject;
  TextEditingController nilaiController = TextEditingController();
  List<Subject> subjects = [];
  List<GradeType> gradeTypes = [];
  int gradeTypeId = 0;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future<void> fetch() async {
    isLoading = true;
    List<Future<List<GradeType>>> futures = [];
    try {
      student =
          await context.read<StudentRepository>().getById(widget.studentId);
      subjects =
          // ignore: use_build_context_synchronously
          await context.read<SubjectRepository>().getByLecturerIdAndStudentId(
              // ignore: use_build_context_synchronously
              (context.read<AuthBloc>().state as AuthLecturer).data.id!,
              student.id!);
      for (Subject subject in subjects) {
        futures.add(
            // ignore: use_build_context_synchronously
            context.read<GradeTypeRepository>().getBySubjectId(subject.id!));
      }
      List<List<GradeType>> results = await Future.wait(futures);
      for (final list in results) {
        for (final gradeType in list) {
          gradeTypes.add(gradeType);
        }
      }
      setState(() {
        isLoading = false;
      });
    } catch (e, s) {
      debugPrint('Error fetching student: $e');
      debugPrint('Stack trace: $s');
    }
  }

  Future<void> submitHandler() async {
    if (subject == null || gradeTypeId == 0 || nilaiController.text.isEmpty) {
      return;
    }
    try {
      isSubmitting = true;
      await context.read<GradeRepository>().create(
          int.parse(nilaiController.text),
          student.id!,
          gradeTypeId,
          subject!.id!);
      isSubmitting = false;
    } catch (e, s) {
      debugPrint('Error adding grade type: $e');
      debugPrint('Stack trace: $s');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PeqingAppbar(
        leadingOnPressed: () {
          context.go(RouteNames.lecturerHome);
        },
        title: Center(
          child: Text(
            'Kasih Nilai',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Icon(
                Iconsax.profile_circle5,
                size: 40,
                color: AppColors.dark[100],
              )),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.only(top: 24, bottom: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildAksiCepatProfile(context),
                    const SizedBox(height: 24),
                    Form(
                        child: Column(
                      children: [
                        _buildPilihMataKuliah(context),
                        const SizedBox(height: 24),
                        _buildRadioButton(context),
                        const SizedBox(height: 24),
                        _buildBeriNilai(context),
                        const SizedBox(height: 24),
                        PeqingButton(
                            isLoading: isSubmitting,
                            text: 'Simpan dan Beri Nilai',
                            onPressed: submitHandler),
                      ],
                    )),
                  ],
                ),
              ),
            ),
    );
  }

  Column _buildBeriNilai(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Beri Nilai',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        PeqingTextfield(
          controller: nilaiController,
          text: 'Masukkan nilai',
        ),
      ],
    );
  }

  Column _buildRadioButton(BuildContext context) {
    var filteredGradeTypes = gradeTypes
        .where((gradeType) => gradeType.subjectId == subject?.id)
        .toList();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Pilih Penugasan',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            GestureDetector(
                onTap: () {},
                child: Text('Tambah',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary[500]!))),
          ],
        ),
        const SizedBox(height: 16),
        filteredGradeTypes.isEmpty
            ? Text('Tidak ada penugasan',
                style: TextStyle(color: AppColors.danger[500]))
            : CupertinoRadioChoice(
                choices: {
                  for (var gradeType in filteredGradeTypes)
                    gradeType.id.toString(): gradeType.name
                },
                onChange: (value) {
                  setState(() {
                    for (var element in gradeTypes) {
                      if (element.id.toString() == value) {
                        gradeTypeId = element.id!;
                      }
                    }
                  });
                },
                initialKeyValue: gradeTypes.first.id.toString(),
                selectedColor: AppColors.primary[500]!,
                notSelectedColor: AppColors.dark[100]!,
              ),
      ],
    );
  }

  Widget _buildPilihMataKuliah(BuildContext context) {
    return InputDecorator(
      decoration: const InputDecoration(),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: subject?.id.toString() ?? '0',
          isDense: true,
          elevation: 2,
          borderRadius: BorderRadius.circular(24),
          dropdownColor: AppColors.white,
          icon: const Icon(Iconsax.arrow_down_1, size: 16),
          onChanged: (String? newValue) {
            setState(() {
              subject = subjects.firstWhere((e) => e.id.toString() == newValue);
            });
          },
          items: [
            DropdownMenuItem<String>(
              value: '0',
              child: SizedBox(
                width: 250,
                child: Text('Pilih mata kuliah',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
              ),
            ),
            ...subjects.map<DropdownMenuItem<String>>((Subject value) {
              return DropdownMenuItem<String>(
                value: value.id.toString(),
                child: SizedBox(
                  width: 250,
                  child: Text(value.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget _buildAksiCepatProfile(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.dark[100]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.profile_circle5,
                size: 40,
                color: AppColors.dark[100],
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(student.user!.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(student.nrp,
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                side: BorderSide(color: AppColors.primary[500]!),
              ),
              onPressed: () {
                context.go(RouteNames.lecturerScanQR);
              },
              child: Text('Ganti',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary[500]))),
        ],
      ),
    );
  }
}
