import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/presentation/widgets/peqing_appbar.dart';
import 'package:peqing/route/route_names.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LecturerScanPage extends StatefulWidget {
  const LecturerScanPage({super.key});

  @override
  State<LecturerScanPage> createState() => _LecturerScanPageState();
}

class _LecturerScanPageState extends State<LecturerScanPage> {
  MobileScannerController cameraController = MobileScannerController();

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
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (barcodeCapture) {
              if (barcodeCapture.barcodes.isNotEmpty) {
                Fluttertoast.showToast(
                  msg: 'QR code detected: ${barcodeCapture.barcodes.first.rawValue}',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            },
          ),
          Container(
            width: 256,
            height: 256,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: AppColors.white.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Icon(Iconsax.scan, size: 128, color: AppColors.white.withOpacity(0.2)),
            ),
          ),
        ],
      ),
    );
  }
}