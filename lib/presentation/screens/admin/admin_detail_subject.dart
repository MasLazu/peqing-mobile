import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/data/models/student.dart';
import 'package:peqing/data/models/subject.dart';
import 'package:peqing/data/repositories/subject_member_repository.dart';
import 'package:peqing/data/repositories/subject_repository.dart';
import 'package:peqing/presentation/widgets/appbars/back_appbar.dart';
import 'package:peqing/presentation/widgets/sheets/subject_member_form.dart';

class AdminDetailSubject extends StatefulWidget {
  final int subjectId;
  const AdminDetailSubject({super.key, required this.subjectId});

  @override
  State<AdminDetailSubject> createState() => _AdminDetailSubjectState();
}

class _AdminDetailSubjectState extends State<AdminDetailSubject> {
  bool isLoading = true;
  late Subject subject;
  late List<Student> subjectMembers;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future<void> fetch() async {
    List<Future> futures = [];
    try {
      futures.add(context.read<SubjectRepository>().getById(widget.subjectId));
      futures.add(context
          .read<SubjectMemberRepository>()
          .getBySubjectId(widget.subjectId));
      List<dynamic> results = await Future.wait(futures);
      subject = results[0] as Subject;
      subjectMembers = results[1] as List<Student>;
      setState(() {
        isLoading = false;
      });
    } catch (e, s) {
      debugPrint('Error fetching subject: $e');
      debugPrint('Stack trace: $s');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppbar(title: 'Detail Mata Kuliah', context: context),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSubjectCard(),
                    const SizedBox(height: 24),
                    _buildHeading('Mahasiswa Terdaftar', onTap: () async {
                      await showSubjectMemberForm(context, widget.subjectId);
                      fetch();
                    }),
                    const SizedBox(height: 14),
                    ...subjectMembers.map((e) => _builStudentCard(e)),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _builStudentCard(Student student) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.dark[100]!),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Iconsax.profile_circle5,
                color: AppColors.dark[100]!,
                size: 48,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(student.user!.name,
                        style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      student.nrp,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  final id = await context
                      .read<SubjectMemberRepository>()
                      .findIdBySubjectIdAndStudentId(
                          widget.subjectId, student.id!);
                  // ignore: use_build_context_synchronously
                  await context.read<SubjectMemberRepository>().deleteById(id);
                  fetch();
                },
                icon: Icon(
                  Iconsax.trash,
                  color: AppColors.danger[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeading(String title, {Function()? onTap}) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Text(
            'Tambah',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.primary[500]),
          ),
        ),
      ],
    );
  }

  Widget _buildSubjectCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.dark[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
                  size: 48,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            subject.name,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Iconsax.teacher5),
              const SizedBox(width: 4),
              Text(subject.lecturer!.user!.name,
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Iconsax.profile_tick5),
              const SizedBox(width: 4),
              Text('${subjectMembers.length} Mahasiswa',
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          )
        ],
      ),
    );
  }
}
