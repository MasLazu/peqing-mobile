import 'package:flutter/material.dart';
import 'package:peqing/presentation/widgets/appbars/root_appbar.dart';
import 'package:peqing/presentation/widgets/cards/history_card.dart';

class LecturerHistoryScreen extends StatefulWidget {
  const LecturerHistoryScreen({super.key});

  @override
  State<LecturerHistoryScreen> createState() => _LecturerHistoryScreenState();
}

class _LecturerHistoryScreenState extends State<LecturerHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RootAppbar(title: 'Riwayat', context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
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
                const SizedBox(height: 12.0),
                HistoryCard(
                  title: 'Berhasil Unggah CSV',
                  description: 'Admin Fulan Berhasil mengunggah',
                  context: context,
                ),
                // const SizedBox(height: 12.0),
                // HistoryCard(
                //   title: 'Berhasil Unggah CSV',
                //   description: 'Admin Fulan Berhasil mengunggah',
                //   context: context,
                // ),
                // const SizedBox(height: 12.0),
                // HistoryCard(
                //   title: 'Berhasil Unggah CSV',
                //   description: 'Admin Fulan Berhasil mengunggah',
                //   context: context,
                // ),
                // const SizedBox(height: 12.0),
                // HistoryCard(
                //   title: 'Berhasil Unggah CSV',
                //   description: 'Admin Fulan Berhasil mengunggah',
                //   context: context,
                // ),
                // const SizedBox(height: 12.0),
                // HistoryCard(
                //   title: 'Berhasil Unggah CSV',
                //   description: 'Admin Fulan Berhasil mengunggah',
                //   context: context,
                // ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
