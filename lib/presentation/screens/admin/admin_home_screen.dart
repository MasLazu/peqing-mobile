import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/presentation/widgets/cards/detail_card.dart';
import 'package:peqing/presentation/widgets/cards/history_card.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: Container(
          color: AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo Admin,',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Fulan bin Fulan',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.dark[100]!,
                  borderRadius: BorderRadius.circular(99),
                  border: Border.all(color: AppColors.dark[200]!, width: 2.0),
                ),
                child: const Icon(
                  Iconsax.profile_2user5,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
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
                onTab: () {},
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

  Text _buildHeading(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _buildCivitasCard({required String title, required IconData icon}) {
    return GestureDetector(
      onTap: () {},
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
