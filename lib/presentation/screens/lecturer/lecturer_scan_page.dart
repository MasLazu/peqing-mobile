import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/data/models/student.dart';
import 'package:peqing/data/repositories/student_repository.dart';
import 'package:peqing/presentation/widgets/peqing_appbar.dart';
import 'package:peqing/route/route_names.dart';

class LecturerScanPage extends StatefulWidget {
  const LecturerScanPage({super.key});

  @override
  State<LecturerScanPage> createState() => _LecturerScanPageState();
}

class _LecturerScanPageState extends State<LecturerScanPage> {
  MobileScannerController cameraController = MobileScannerController();

  Student? student;

  Future<void> handleScan(String studentId) async {
    try {
      final id = int.tryParse(studentId);
      if (id == null) return;
      final newStudent =
          await RepositoryProvider.of<StudentRepository>(context).getById(id);
      setState(() {
        student = newStudent;
      });
    } catch (e, s) {
      debugPrint('Error parsing studentId: $e');
      debugPrintStack(stackTrace: s);
    }
  }

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
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Icon(
                Iconsax.profile_circle5,
                size: 40,
                color: AppColors.dark[100],
              )),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (barcodeCapture) {
              if (barcodeCapture.barcodes.isNotEmpty) {
                handleScan(barcodeCapture.barcodes.first.rawValue!);
              }
            },
          ),
          Container(
            width: 256,
            height: 256,
            decoration: BoxDecoration(
              border:
                  Border.all(width: 2, color: AppColors.white.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Icon(Iconsax.scan,
                  size: 128, color: AppColors.white.withOpacity(0.2)),
            ),
          ),
          student != null
              ? Positioned(
                  bottom: 52,
                  child: GestureDetector(
                    onTap: () {
                      context
                          .go('${RouteNames.lecturerAddGrade}/${student!.id}');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width - 48,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.dark[100]!),
                        color: AppColors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Iconsax.profile_circle5,
                                color: AppColors.dark[500]!,
                                size: 48,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(student!.user.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                    Text(
                                      'Mahasiswa ditemukan, kasih nilai!',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Iconsax.arrow_right_3,
                                color: AppColors.dark[500],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
