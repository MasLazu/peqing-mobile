import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/presentation/widgets/peqing_appbar.dart';
import 'package:peqing/route/route_names.dart';

class LecturerScanPage extends StatefulWidget {
  const LecturerScanPage({super.key});

  @override
  State<LecturerScanPage> createState() => _LecturerScanPageState();
}

class _LecturerScanPageState extends State<LecturerScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PeqingAppbar(
        leadingOnPressed: () {
          context.go(RouteNames.lecturerHome);
        },
        title: Center(
          child: Text(
            'Scan QR Mahasiswa',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Icon(Iconsax.profile_circle5, size: 40, color: AppColors.dark[100],)
          ),
        ],
      ),
      body: const Center(
        child: Text('Scan QR Mahasiswa'),
      ),
    );
  }
}