import 'package:flutter/material.dart';
import 'package:peqing/presentation/widgets/appbar/root_appbar.dart';

class AdminHistoryScreen extends StatefulWidget {
  const AdminHistoryScreen({super.key});

  @override
  State<AdminHistoryScreen> createState() => _AdminHistoryScreenState();
}

class _AdminHistoryScreenState extends State<AdminHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RootAppbar(title: 'Riwayat', context: context),
      body: const Center(
        child: Text('Riwayat'),
      ),
    );
  }
}
