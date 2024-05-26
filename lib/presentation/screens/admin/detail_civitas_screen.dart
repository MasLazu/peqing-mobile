import 'package:flutter/material.dart';
import 'package:peqing/presentation/widgets/appbars/back_appbar.dart';

class DetailCivitasScreen extends StatefulWidget {
  const DetailCivitasScreen({super.key});

  @override
  State<DetailCivitasScreen> createState() => _DetailCivitasScreenState();
}

class _DetailCivitasScreenState extends State<DetailCivitasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppbar(context: context, title: 'Detail Civitas'),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
