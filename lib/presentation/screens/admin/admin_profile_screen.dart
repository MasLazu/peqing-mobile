import 'package:flutter/material.dart';
import 'package:peqing/presentation/widgets/appbar/root_appbar.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RootAppbar(title: 'Profil', context: context),
      body: const Center(
        child: Text('Profile'),
      ),
    );
  }
}
