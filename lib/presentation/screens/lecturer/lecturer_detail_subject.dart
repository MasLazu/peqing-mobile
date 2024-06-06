import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/data/models/grade_type.dart';
import 'package:peqing/data/models/subject.dart';
import 'package:peqing/data/repositories/grade_type_repository.dart';
import 'package:peqing/data/repositories/subject_repository.dart';
import 'package:peqing/presentation/widgets/appbars/back_appbar.dart';
import 'package:peqing/presentation/widgets/sheets/grade_type_form.dart';

class LecturerDetailSubject extends StatefulWidget {
  final int subjectId;
  const LecturerDetailSubject({super.key, required this.subjectId});

  @override
  State<LecturerDetailSubject> createState() => _LecturerDetailSubjectState();
}

class _LecturerDetailSubjectState extends State<LecturerDetailSubject> {
  bool isLoading = true;
  late Subject subject;
  late List<GradeType> gradeTypes;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future<void> fetch() async {
    List<Future> futures = [];
    try {
      futures.add(context.read<SubjectRepository>().getById(widget.subjectId));
      futures.add(
          context.read<GradeTypeRepository>().getBySubjectId(widget.subjectId));
      List<dynamic> results = await Future.wait(futures);
      subject = results[0] as Subject;
      gradeTypes = results[1] as List<GradeType>;
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
                    _buildHeading('Penugasan', onTap: () async {
                      await showGradeTypeForm(context, widget.subjectId);
                      fetch();
                    }),
                    const SizedBox(height: 14),
                    ...gradeTypes.map((e) => Column(
                          children: [
                            const SizedBox(height: 15),
                            _buildGradeTypeCard(e),
                          ],
                        )),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildGradeTypeCard(GradeType gradeType) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.dark[100]!),
      ),
      child:
          Text(gradeType.name, style: Theme.of(context).textTheme.titleMedium),
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
              const Icon(Iconsax.archive_15),
              const SizedBox(width: 4),
              Text('${gradeTypes.length} Penugasan',
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          )
        ],
      ),
    );
  }
}
