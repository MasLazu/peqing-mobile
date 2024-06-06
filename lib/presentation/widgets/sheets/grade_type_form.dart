import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/bloc/lecturer/lecturer_bloc.dart';
import 'package:peqing/data/models/grade_type.dart';
import 'package:peqing/data/repositories/grade_type_repository.dart';
import 'package:peqing/presentation/widgets/buttons/peqing_button.dart';

Future<void> showGradeTypeForm(BuildContext context, int subjectId) async {
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
  late final _nameController = TextEditingController();
  bool isLoading = false;

  void submitHandler() async {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      try {
        await context.read<GradeTypeRepository>().create(
            GradeType(name: _nameController.text, subjectId: widget.subjectId));
        isLoading = false;
        // ignore: use_build_context_synchronously
        context.pop();
      } catch (e, s) {
        debugPrint('Error adding grade type: $e');
        debugPrint('Stack trace: $s');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
                  'Tambah Penugasan',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              BlocBuilder<LecturerBloc, LecturerState>(
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Nama Penugasan',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: 'Masukkan nama penugasan',
                          ),
                          validator: (value) {
                            value = value?.trim();
                            if (value == null || value.isEmpty) {
                              return 'Masukkan Nama Penugasan';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24.0),
                        PeqingButton(
                          text: 'Tambah Penugasan Baru',
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
      ),
    );
  }
}
