import 'package:flutter/material.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/core/theme/app_theme.dart';

class PeqingButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isLoading;
  final Color color;

  PeqingButton({
    super.key,
    required this.text,
    required this.onPressed,
    Color? color,
    this.isLoading = false,
  }) : color = color ?? AppColors.primary[500]!;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed as void Function()?,
        style: ButtonStyle(backgroundColor: WidgetStateProperty.all(color)),
        child: isLoading
            ? const SizedBox(
                height: 18.0,
                width: 18.0,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 3,
                ),
              )
            : Text(
                text,
                style: AppTheme.textStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
