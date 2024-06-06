import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/bloc/student/student_bloc.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/data/repositories/subject_member_repository.dart';
import 'package:peqing/presentation/widgets/buttons/peqing_button.dart';

Future<void> showSubjectMemberForm(BuildContext context, int subjectId) async {
  await showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    isDismissible: false,
    builder: (BuildContext context) {
      return SubjectForm(
        subjectId: subjectId,
      );
    },
  );
}

class SubjectForm extends StatefulWidget {
  final int subjectId;
  const SubjectForm({super.key, required this.subjectId});

  @override
  State<SubjectForm> createState() => _SubjectFormState();
}

class _SubjectFormState extends State<SubjectForm> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  int? _studentId;

  void submitHandler() async {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      await context
          .read<SubjectMemberRepository>()
          .create(widget.subjectId, _studentId!);
      isLoading = false;
      // ignore: use_build_context_synchronously
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Iconsax.arrow_left),
                onPressed: () => context.pop(),
              ),
              title: Text(
                'Tambah Mata Kuliah PENS',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            BlocBuilder<StudentBloc, StudentState>(
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Mahasiswa',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      InputDecorator(
                        decoration: const InputDecoration(),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _studentId?.toString() ?? '0',
                            isDense: true,
                            elevation: 2,
                            borderRadius: BorderRadius.circular(24),
                            dropdownColor: AppColors.white,
                            icon: const Icon(Iconsax.arrow_down_1, size: 16),
                            onChanged: (String? newValue) {
                              setState(() {
                                setState(() {
                                  _studentId = int.tryParse(newValue!);
                                });
                              });
                            },
                            items: state is StudentLoaded
                                ? [
                                    const DropdownMenuItem<String>(
                                      value: '0',
                                      child: Text('Pilih mahasiswa'),
                                    ),
                                    ...state.students
                                        .map<DropdownMenuItem<String>>(
                                            (lecturer) {
                                      return DropdownMenuItem<String>(
                                        value: lecturer.id.toString(),
                                        child: SizedBox(
                                          width: 100,
                                          child: Text(
                                            lecturer.user!.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ),
                                      );
                                    }),
                                  ]
                                : [
                                    const DropdownMenuItem<String>(
                                      value: '0',
                                      child: Text('Select a lecturer'),
                                    )
                                  ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      PeqingButton(
                        isLoading: isLoading,
                        text: 'Tambah Mahasiswa ke Kelas',
                        onPressed: submitHandler,
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
