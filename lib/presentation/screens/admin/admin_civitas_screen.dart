import 'package:flutter/material.dart';
import 'package:peqing/presentation/widgets/appbars/root_appbar.dart';

class AdminCivitasScreen extends StatefulWidget {
  const AdminCivitasScreen({super.key});

  @override
  State<AdminCivitasScreen> createState() => _AdminCivitasScreenState();
}

class _AdminCivitasScreenState extends State<AdminCivitasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RootAppbar(title: 'Daftar Civitas PENS', context: context),
      body: const Center(
        child: Text('Darftar Civitas'),
      ),
    );
  }
}
