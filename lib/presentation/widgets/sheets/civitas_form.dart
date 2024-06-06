import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';
import 'package:peqing/bloc/lecturer/lecturer_bloc.dart';
import 'package:peqing/bloc/student/student_bloc.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/data/models/lecturer.dart';
import 'package:peqing/data/models/role.dart';
import 'package:peqing/data/models/student.dart';
import 'package:peqing/data/models/user.dart';
import 'package:peqing/data/repositories/auth_repository.dart';
import 'package:peqing/presentation/widgets/buttons/peqing_button.dart';

void showCivitasForm(BuildContext context, {Role? data}) {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    isDismissible: false,
    builder: (BuildContext context) {
      return CivitasForm(data: data);
    },
  );
}

class CivitasForm extends StatefulWidget {
  final Role? data;
  const CivitasForm({super.key, this.data});

  @override
  State<CivitasForm> createState() => _CivitasFormState();
}

class _CivitasFormState extends State<CivitasForm> {
  final _formKey = GlobalKey<FormState>();

  late final _idController = TextEditingController(
      text: widget.data != null
          ? widget.data is Student
              ? (widget.data as Student).nrp
              : (widget.data as Lecturer).nip
          : null);
  late final _emailController =
      TextEditingController(text: widget.data?.user!.email);
  late final _nameController =
      TextEditingController(text: widget.data?.user!.name);
  final List<String> _roles = <String>['Admin', 'Dosen', 'Mahasiswa'];
  late String role = widget.data?.role ?? _roles[0];
  final List<String> _departements = <String>[
    'Departemen Teknik Elektro',
    'Departemen Teknik Informatika dan Komputer',
    'Departemen Teknik Mekanika Energi',
    'Departemen Multimedia Kreatif'
  ];
  late String departement = (widget.data is Student)
      ? (widget.data as Student).departement
      : _departements[0];
  final List<String> _majors = <String>[
    'Teknik Elektro',
    'Teknik Informatika',
    'Teknik Mekanika Energi',
    'Multimedia Kreatif',
    'Sains Data Terapan',
    'Teknik Komputer',
    'Teknik Elektro Industri',
    'Teknik Mekatronika',
  ];
  late String major =
      (widget.data is Student) ? (widget.data as Student).major : _majors[0];
  bool isLoading = false;

  Future<void> submitHandler() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        switch (role) {
          case 'Admin':
            await context.read<AuthRepository>().register(User(
                name: _nameController.text,
                email: _emailController.text,
                password: 'admin'));
            break;
          case 'Dosen':
            var lecturer = Lecturer(
              user: User(
                name: _nameController.text,
                email: _emailController.text,
                id: widget.data != null
                    ? (widget.data as Lecturer).user!.id
                    : null,
                password: 'dosen',
              ),
              id: widget.data != null ? (widget.data as Lecturer).id : null,
              nip: _idController.text,
            );
            if (widget.data != null) {
              context.read<LecturerBloc>().add(UpdateLecturer(lecturer));
            } else {
              context.read<LecturerBloc>().add(CreateLecturer(lecturer));
            }
            break;
          case 'Mahasiswa':
            var student = Student(
              user: User(
                name: _nameController.text,
                email: _emailController.text,
                password: 'mahasiswa',
                id: widget.data != null
                    ? (widget.data as Student).user!.id
                    : null,
              ),
              id: widget.data != null ? (widget.data as Student).id : null,
              nrp: _idController.text,
              departement: departement,
              major: major,
            );
            if (widget.data != null) {
              context.read<StudentBloc>().add(UpdateStudent(student));
            } else {
              context.read<StudentBloc>().add(CreateStudent(student));
            }
            break;
          default:
        }
        // ignore: use_build_context_synchronously
        context.pop();
      } catch (e) {
        debugPrint('''
=================ERROR=====================
${e.toString()}
===========================================
''');
        // ignore: use_build_context_synchronously
        context.pop();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.danger[400]!,
            content: Text(e.toString()),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
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
                widget.data == null
                    ? 'Tambah Civitas PENS'
                    : 'Ubah Civitas PENS',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  widget.data == null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pilih Role',
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
                                  value: role,
                                  isDense: true,
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(24),
                                  dropdownColor: AppColors.white,
                                  icon: const Icon(Iconsax.arrow_down_1,
                                      size: 16),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      role = newValue!;
                                    });
                                  },
                                  items: _roles.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: SizedBox(
                                        width: 100,
                                        child: Text(value,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                          ],
                        )
                      : const SizedBox(),
                  role != 'Admin'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(
                                role == 'Dosen'
                                    ? 'Masukkan NIP'
                                    : 'Masukkan NRP',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8.0),
                              TextFormField(
                                controller: _idController,
                                decoration: InputDecoration(
                                  hintText: role == 'Dosen'
                                      ? 'Masukkan NIP'
                                      : 'Masukkan NRP',
                                ),
                                validator: (value) {
                                  value = value?.trim();
                                  if (value == null || value.isEmpty) {
                                    return role == 'Dosen'
                                        ? 'Masukkan NIP'
                                        : 'Masukkan NRP';
                                  }
                                  return null;
                                },
                              )
                            ])
                      : const SizedBox(),
                  const SizedBox(height: 16.0),
                  Text(
                    'Email Civitas',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Email Civitas',
                    ),
                    validator: (value) {
                      value = value?.trim();
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Email Civitas';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Nama Civitas',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Nama Civitas',
                    ),
                    validator: (value) {
                      value = value?.trim();
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Nama Civitas';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  role == 'Mahasiswa'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(
                                'Pilih Departemen',
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
                                    value: departement,
                                    isDense: true,
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(24),
                                    dropdownColor: AppColors.white,
                                    icon: const Icon(Iconsax.arrow_down_1,
                                        size: 16),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        departement = newValue!;
                                      });
                                    },
                                    items: _departements
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: SizedBox(
                                          width: 250,
                                          child: Text(value,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ])
                      : const SizedBox(),
                  const SizedBox(height: 16.0),
                  role == 'Mahasiswa'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(
                                'Pilih Jurusan',
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
                                    value: major,
                                    isDense: true,
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(24),
                                    dropdownColor: AppColors.white,
                                    icon: const Icon(Iconsax.arrow_down_1,
                                        size: 16),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        major = newValue!;
                                      });
                                    },
                                    items: _majors
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: SizedBox(
                                          width: 250,
                                          child: Text(value,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ])
                      : const SizedBox(),
                  const SizedBox(height: 24.0),
                  PeqingButton(
                    text: widget.data == null
                        ? 'Tambah Civitas Baru'
                        : 'Ubah data Civitas',
                    isLoading: isLoading,
                    onPressed: submitHandler,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
