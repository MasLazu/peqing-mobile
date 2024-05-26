import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/data/models/users/lecturer.dart';
import 'package:peqing/data/models/users/student.dart';
import 'package:peqing/data/models/users/user.dart';
import 'package:peqing/data/repositories/auth_repository.dart';
import 'package:peqing/data/repositories/lecturer_repository.dart';
import 'package:peqing/data/repositories/student_repository.dart';
import 'package:peqing/presentation/widgets/buttons/peqing_button.dart';

void showCivitasForm(BuildContext context) {
  showModalBottomSheet<void>(
    useRootNavigator: true,
    isScrollControlled: true,
    context: context,
    isDismissible: false,
    builder: (BuildContext context) {
      return const CivitasForm();
    },
  );
}

class CivitasForm extends StatefulWidget {
  const CivitasForm({super.key});

  @override
  State<CivitasForm> createState() => _CivitasFormState();
}

class _CivitasFormState extends State<CivitasForm> {
  final _formKey = GlobalKey<FormState>();

  final _idController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final List<String> _roles = <String>['Admin', 'Dosen', 'Mahasiswa'];
  late String role = _roles[0];
  final List<String> _departements = <String>[
    'Departemen Teknik Elektro',
    'Departemen Teknik Informatika dan Komputer',
    'Departemen Teknik Mekanika Energi',
    'Departemen Multimedia Kreatif'
  ];
  late String departement = _departements[0];
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
  late String major = _majors[0];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
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
                  'Tambah Civitas PENS',
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
                          icon: const Icon(Iconsax.arrow_down_1, size: 16),
                          onChanged: (String? newValue) {
                            setState(() {
                              role = newValue!;
                            });
                          },
                          items: _roles
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 100,
                                child: Text(value,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
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
                      obscureText: true,
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
                      obscureText: true,
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
                      text: 'Tambah Civitas Baru',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          isLoading = true;
                          try {
                            switch (role) {
                              case 'Admin':
                                context.read<AuthRepository>().register(User(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    password: 'admin'));
                                break;
                              case 'Dosen':
                                context.read<LecturerRepository>().createOne(
                                    Lecturer(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        password: 'dosen',
                                        nip: _idController.text));
                                break;
                              case 'Mahasiswa':
                                context
                                    .read<StudentRepository>()
                                    .createOne(Student(
                                      nrp: _idController.text,
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      departerment: departement,
                                      major: major,
                                      password: 'mahasiswa',
                                    ));
                                break;
                              default:
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                          }
                          isLoading = false;
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
