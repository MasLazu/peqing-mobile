import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/core/theme/app_colors.dart';

enum DetailCardType {
  normal,
  gradient,
}

class DetailCard extends Card {
  final String title;
  final String description;
  final IconData icon;
  final DetailCardType type;
  final VoidCallback onTab;
  DetailCard({
    super.key,
    required BuildContext context,
    required this.title,
    required this.icon,
    required this.description,
    this.type = DetailCardType.normal,
    required this.onTab,
  }) : super(
          elevation: 0,
          margin: const EdgeInsets.all(0),
          color: AppColors.white,
          child: GestureDetector(
            onTap: onTab,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: type == DetailCardType.gradient
                    ? Border.all(width: 0, color: AppColors.lightGrey)
                    : Border.all(color: AppColors.dark[100]!),
                gradient: type == DetailCardType.gradient
                    ? LinearGradient(
                        colors: [
                          AppColors.primary[300]!,
                          AppColors.primary[500]!
                        ], // Replace with your desired colors
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: type == DetailCardType.gradient
                                  ? AppColors.primary[500]!
                                  : AppColors.dark[500]!,
                              borderRadius: BorderRadius.circular(99)),
                          child: Icon(icon, color: AppColors.white),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title,
                                  style: type == DetailCardType.gradient
                                      ? Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(color: AppColors.white)
                                      : Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                              Text(
                                description,
                                style: type == DetailCardType.gradient
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: AppColors.white)
                                    : Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Iconsax.arrow_right_3,
                          color: type == DetailCardType.gradient
                              ? AppColors.white
                              : AppColors.dark[500],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
}
