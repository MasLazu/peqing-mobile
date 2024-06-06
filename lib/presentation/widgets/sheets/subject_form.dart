import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/bloc/lecturer/lecturer_bloc.dart';
import 'package:peqing/bloc/suject/subject_bloc.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/data/models/subject.dart';
import 'package:peqing/presentation/widgets/buttons/peqing_button.dart';

void showSubjectForm(BuildContext context) {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    isDismissible: false,
    builder: (BuildContext context) {
      return const SubjectForm();
    },
  );
}

class SubjectForm extends StatefulWidget {
  final Subject? data;
  const SubjectForm({super.key, this.data});

  @override
  State<SubjectForm> createState() => _SubjectFormState();
}

class _SubjectFormState extends State<SubjectForm> {
  final _formKey = GlobalKey<FormState>();
  late int? _lecturerId = widget.data?.lecturer?.id;
  late final _nameController =
      TextEditingController(text: widget.data?.name ?? '');

  void submitHandler() {
    if (_formKey.currentState!.validate()) {
      if (widget.data == null) {
        context.read<SubjectBloc>().add(
              CreateSubject(
                Subject(
                  name: _nameController.text,
                ),
                _lecturerId!,
              ),
            );
      } else {
        context.read<SubjectBloc>().add(
              UpdateSubject(
                Subject(
                  id: widget.data!.id,
                  name: _nameController.text,
                ),
              ),
            );
      }
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
            BlocBuilder<LecturerBloc, LecturerState>(
              builder: (context, state) {
                return Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            'Nama Mata Kuliah',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              hintText: 'Masukkan Nama Mata Kuliah',
                            ),
                            validator: (value) {
                              value = value?.trim();
                              if (value == null || value.isEmpty) {
                                return 'Masukkan Nama Mata Kuliah';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            'Dosen Pengampu',
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
                                value: _lecturerId?.toString() ?? '0',
                                isDense: true,
                                elevation: 2,
                                borderRadius: BorderRadius.circular(24),
                                dropdownColor: AppColors.white,
                                icon:
                                    const Icon(Iconsax.arrow_down_1, size: 16),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    setState(() {
                                      _lecturerId = int.tryParse(newValue!);
                                    });
                                  });
                                },
                                items: state is LecturerLoaded
                                    ? [
                                        const DropdownMenuItem<String>(
                                          value: '0',
                                          child: Text('Pilih dosen pengampu'),
                                        ),
                                        ...state.lecturers
                                            .map<DropdownMenuItem<String>>(
                                                (lecturer) {
                                          return DropdownMenuItem<String>(
                                            value: lecturer.id.toString(),
                                            child: SizedBox(
                                              width: 100,
                                              child: Text(
                                                lecturer.user.name,
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
                            text: widget.data == null
                                ? 'Tambah Civitas Baru'
                                : 'Ubah data Civitas',
                            onPressed: submitHandler,
                          ),
                        ]));
              },
            )
          ],
        ),
      ),
    );
  }
}
