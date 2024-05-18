import 'package:flutter/material.dart';

class AdminCivitasScreen extends StatefulWidget {
  const AdminCivitasScreen({super.key});

  @override
  State<AdminCivitasScreen> createState() => _AdminCivitasScreenState();
}

class _AdminCivitasScreenState extends State<AdminCivitasScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Darftar Civitas'),
      ),
    );
  }
}
