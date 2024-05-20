import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/presentation/widgets/appbars/welcome_appbar.dart';
import 'package:peqing/presentation/widgets/buttons/peqing_button.dart';
import 'package:peqing/presentation/widgets/cards/detail_card.dart';
import 'package:peqing/presentation/widgets/cards/history_card.dart';
import 'package:peqing/route/route_names.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WelcomeAppbar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeading('Daftar Civitas'),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                      child: _buildCivitasCard(
                          title: 'Data Dosen', icon: Iconsax.teacher5)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildCivitasCard(
                        title: 'Data Mahasiswa', icon: Iconsax.profile_add5),
                  )
                ],
              ),
              const SizedBox(height: 28),
              _buildHeading('Unggah Data'),
              const SizedBox(height: 16.0),
              DetailCard(
                context: context,
                title: 'Buat Data Manual',
                icon: Iconsax.keyboard5,
                description: 'Unggah data dengan mengisi manual',
                onTab: () {
                  showModalBottomSheet<void>(
                    useRootNavigator: true,
                    isScrollControlled: true,
                    context: context,
                    isDismissible: false,
                    builder: (BuildContext context) {
                      return _buildAddCivitasForm(context);
                    },
                  );
                },
              ),
              const SizedBox(height: 12.0),
              DetailCard(
                context: context,
                type: DetailCardType.gradient,
                title: 'Unggah via CSV',
                icon: Iconsax.document5,
                description: 'Impor data mahasiswa & dosen',
                onTab: () {},
              ),
              const SizedBox(height: 24.0),
              _buildHeading('Riwayat'),
              const SizedBox(height: 16.0),
              HistoryCard(
                title: 'Berhasil Unggah CSV',
                description: 'Admin Fulan Berhasil mengunggah',
                context: context,
              ),
              const SizedBox(height: 12.0),
              HistoryCard(
                title: 'Berhasil Unggah CSV',
                description: 'Admin Fulan Berhasil mengunggah',
                context: context,
              ),
              const SizedBox(height: 12.0),
              HistoryCard(
                title: 'Berhasil Unggah CSV',
                description: 'Admin Fulan Berhasil mengunggah',
                context: context,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddCivitasForm(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final idController = TextEditingController();
    final nameController = TextEditingController();

    return SizedBox(
      width: double.infinity,
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
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'ID Pengenal',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: idController,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan NRP / NIP',
                    ),
                    validator: (value) {
                      value = value?.trim();
                      if (value == null || value.isEmpty) {
                        return 'Masukkan NRP / NIP';
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
                    controller: nameController,
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
                        value: 'Mahaasiswa',
                        isDense: true,
                        elevation: 2,
                        borderRadius: BorderRadius.circular(24),
                        dropdownColor: AppColors.white,
                        icon: const Icon(Iconsax.arrow_down_1, size: 16),
                        onChanged: (String? newValue) {},
                        items: <String>['Admin', 'Dosen', 'Mahaasiswa']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  PeqingButton(
                    text: 'Tambah Civitas Baru',
                    onPressed: () {},
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

  Text _buildHeading(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _buildCivitasCard({required String title, required IconData icon}) {
    return GestureDetector(
      onTap: () {
        context.go(RouteNames.adminCivitas);
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.dark[100]!)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: AppColors.dark[500]!,
                  borderRadius: BorderRadius.circular(99)),
              child: Icon(
                icon,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 24.0),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Lihat data di sini',
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(width: 4),
              const Icon(Iconsax.arrow_right_1, size: 16),
            ]),
          ],
        ),
      ),
    );
  }
}
