import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/presentation/widgets/peqing_appbar.dart';

class LecturerHomePage extends StatelessWidget {
  const LecturerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PeqingAppbar(
        showBackIcon: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Halo Dosen,', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text('Fulan bin Fulan', style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Image.asset('assets/images/img-profile.png', width: 48),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        margin: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAksiCepat(context),
            const SizedBox(height: 24),
            _buildScanQR(context),
            const SizedBox(height: 24),
            _buildRiwayatHome(context)
          ],
        ),
      ),
    );
  }

  Column _buildRiwayatHome(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Riwayat', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                side: BorderSide(color: AppColors.primary[500]!),
              ),
              onPressed: () {}, 
              child: Text(
                'Hari ini', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary[500]))
              ),
          ],
        ),
        const SizedBox(height: 16),
        _buildRiwayatCard(context),
        const SizedBox(height: 12),
        _buildRiwayatCard(context),
      ],
    );
  }

  Container _buildRiwayatCard(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16), // Add padding here (16
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.dark[100]!),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kamu barusan ngasih nilai!', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                  'Kamu ngasih 81 di Tugas 1 Pemrograman Berbasis Objek ke Fulan bin Fulan!',
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(Iconsax.arrow_right_3, size: 24)
          ],
        ),
      );
  }

  Column _buildScanQR(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mau Ngasih Nilai?', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16), // Add padding here (16
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary[400]!, AppColors.primary[500]!],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary[500],
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: const Icon(Iconsax.scan, color: AppColors.white, size: 24)
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text('Beri Nilai Sekarang', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Scan QR mahasiswa lalu nilai!', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.white)),
                    ],
                  )
                ],
              ),
              const Icon(Iconsax.arrow_right_3, color: AppColors.white, size: 24)
            ],
          ),
        )
      ],
    );
  }

  Column _buildAksiCepat(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Aksi Cepat, SatSet!', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildAksiCepatProfile(context),
              const SizedBox(width: 12),
              _buildAksiCepatProfile(context),
              const SizedBox(width: 12),
              _buildAksiCepatProfile(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAksiCepatProfile(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: AppColors.dark[100]!),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/img-profile.png', width: 40),
          const SizedBox(width: 8,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Kasih nilai ke', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 2,),
              Text('Fulan bin Fulan', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(width: 8,),
        ],
      ),
    );
  }
}