import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/data/models/grade.dart';
import 'package:peqing/data/models/grade_type.dart';
import 'package:peqing/data/repositories/grade_repository.dart';
import 'package:peqing/data/repositories/grade_type_repository.dart';
import 'package:peqing/presentation/widgets/appbars/back_appbar.dart';

class StudentDetailSubjectScreen extends StatefulWidget {
  final int subjectId;
  const StudentDetailSubjectScreen({super.key, required this.subjectId});

  @override
  State<StudentDetailSubjectScreen> createState() =>
      _StudentDetailSubjectScreenState();
}

class _StudentDetailSubjectScreenState
    extends State<StudentDetailSubjectScreen> {
  List<GradeType> gradeTypes = [];
  bool isLoading = true;
  List<Grade> grades = [];

  Future<void> fetch() async {
    isLoading = true;
    try {
      gradeTypes = await context
          .read<GradeTypeRepository>()
          .getBySubjectId(widget.subjectId);
      grades.addAll(await context
          .read<GradeRepository>()
          .getByStudentIdAndSubjectId(
              (context.read<AuthBloc>().state as AuthStudent).data.id!,
              widget.subjectId));
    } catch (e, s) {
      debugPrint('Error fetching subject: $e');
      debugPrint('Stack trace: $s');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppbar(context: context, title: 'Detail Mata Kuliah'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nilai Kamu',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 1.3,
                  padding: const EdgeInsets.only(bottom: 24.0),
                  children: [
                    for (GradeType gradeType in gradeTypes)
                      _buildGradeTypeCard(gradeType),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradeTypeCard(GradeType gradeType) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            gradeType.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Nilai: ${grades.firstWhere((e) => e.gradeTypeId == gradeType.id).score}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
