import 'package:flutter/material.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/core/theme/app_theme.dart';

class PeqingOutlineButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color? color;
  final Alignment align;
  final IconData? icon;

  const PeqingOutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.align = Alignment.center,
    this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: onPressed as void Function()?,
        style: OutlinedButton.styleFrom(
          alignment: align,
          side: BorderSide(color: color ?? AppColors.dark[100]!),
          backgroundColor: AppColors.white,
          foregroundColor: color ?? AppColors.dark[100],
        ),
        child: Row(
          children: [
            icon != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(icon, color: color ?? AppColors.dark[500]),
                  )
                : const SizedBox(),
            Text(
              text,
              style: AppTheme.textStyle(
                color: color ?? AppColors.dark[500],
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
