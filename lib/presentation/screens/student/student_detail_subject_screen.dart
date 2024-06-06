import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/core/theme/app_colors.dart';
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
      grades = await context.read<GradeRepository>().getByStudentIdAndSubjectId(
          (context.read<AuthBloc>().state as AuthStudent).data.id!,
          widget.subjectId);
      setState(() {
        isLoading = false;
      });
    } catch (e, s) {
      debugPrint('Error fetching subject: $e');
      debugPrint('Stack trace: $s');
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppbar(context: context, title: 'Detail Mata Kuliah'),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nilai Kamu',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 15.0,
                        childAspectRatio: 1.4,
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
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            gradeType.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Builder(builder: (context) {
            Grade? grade;
            for (Grade g in grades) {
              if (g.gradeTypeId == gradeType.id) {
                grade = g;
                break;
              }
            }
            if (grade == null) {
              return Expanded(
                child: Center(
                  child: Text(
                    'Belum ada nilai',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              );
            }
            return Expanded(
              child: Center(
                child: Text(
                  grade.grade,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.primary[500],
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
