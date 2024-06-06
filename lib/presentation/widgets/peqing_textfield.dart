import 'package:flutter/material.dart';
import 'package:peqing/core/theme/app_colors.dart';

class PeqingTextfield extends StatelessWidget {
  final String text;
  final IconData? icon;
  final TextEditingController? controller;

  const PeqingTextfield(
      {super.key, required this.text, this.icon, this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.dark[100]!),
          ),
          suffixIcon: Icon(icon),
        ),
      ),
    );
  }
}
