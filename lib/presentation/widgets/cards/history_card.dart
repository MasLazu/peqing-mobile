import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/core/theme/app_colors.dart';

class HistoryCard extends Card {
  final String title;
  final String description;

  HistoryCard({
    super.key,
    required BuildContext context,
    required this.title,
    required this.description,
  }) : super(
          elevation: 0,
          margin: const EdgeInsets.all(0),
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
            side: BorderSide(color: AppColors.dark[100]!),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Berhasil Unggah CSV',
                              style: Theme.of(context).textTheme.titleMedium),
                          Text(
                            'Admin Fulan Berhasil mengunggah',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: AppColors.success[500]!,
                          borderRadius: BorderRadius.circular(99)),
                      child: const Icon(
                        Iconsax.clock5,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
}
