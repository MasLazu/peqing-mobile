import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/core/theme/app_colors.dart';

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
                      child: _buildCard(
                          title: 'Data Dosen', icon: Iconsax.teacher5)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildCard(
                        title: 'Data Mahasiswa', icon: Iconsax.profile_add5),
                  )
                ],
              ),
              const SizedBox(height: 28),
              _buildHeading('Unggah Data'),
              const SizedBox(height: 16.0),
              _buildUnggahDataCard(
                  title: 'Buat Data Manual',
                  description: 'Unggah data dengan mengisi manual'),
              const SizedBox(height: 12.0),
              _buildUnggahDataCard(
                  type: 2,
                  title: 'Unggah via CSV',
                  description: 'Impor data mahasiswa & dosen'),
              const SizedBox(height: 24.0),
              _buildHeading('Riwayat'),
              const SizedBox(height: 16.0),
              _buildRiwayatCard(),
              const SizedBox(height: 12.0),
              _buildRiwayatCard(),
              const SizedBox(height: 12.0),
              _buildRiwayatCard(),
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

  Widget _buildRiwayatCard() {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(0),
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
        side: BorderSide(color: AppColors.dark[100]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Berhasil Unggah CSV',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text(
                        'Admin Fulan Berhasil mengunggah',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: AppColors.success[500]!,
                      borderRadius: BorderRadius.circular(99)),
                  child: const Icon(
                    Iconsax.clock5,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card _buildUnggahDataCard(
      {required String title, required String description, int type = 1}) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(0),
      color: AppColors.white,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.dark[100]!),
          gradient: type == 2
              ? LinearGradient(
                  colors: [
                    AppColors.primary[300]!,
                    AppColors.primary[500]!
                  ], // Replace with your desired colors
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: type == 2
                            ? AppColors.primary[500]!
                            : AppColors.dark[500]!,
                        borderRadius: BorderRadius.circular(99)),
                    child: const Icon(
                      Iconsax.keyboard5,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: type == 2
                                ? Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: AppColors.white)
                                : Theme.of(context).textTheme.titleMedium),
                        Text(
                          description,
                          style: type == 2
                              ? Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppColors.white)
                              : Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Iconsax.arrow_right_3,
                      color: type == 2 ? AppColors.white : AppColors.dark[500],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required IconData icon}) {
    return Container(
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
    );
  }
}
