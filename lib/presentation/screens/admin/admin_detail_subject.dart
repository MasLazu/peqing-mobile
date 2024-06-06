import 'package:flutter/material.dart';
import 'package:peqing/presentation/widgets/appbars/back_appbar.dart';

class AdminDetailSubject extends StatefulWidget {
  final int subjectId;
  const AdminDetailSubject({super.key, required this.subjectId});

  @override
  State<AdminDetailSubject> createState() => _AdminDetailSubjectState();
}

class _AdminDetailSubjectState extends State<AdminDetailSubject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppbar(title: 'Detail Mata Kuliah', context: context),
    );
  }
}
