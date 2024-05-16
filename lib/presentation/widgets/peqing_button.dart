import 'package:flutter/material.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/core/theme/app_theme.dart';

class PeqingButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const PeqingButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed as void Function()?,
      child: Text(
        text,
        style: AppTheme.textStyle(
          color: AppColors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
