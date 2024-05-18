import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/core/theme/app_colors.dart';

class BackAppbar extends PreferredSize {
  BackAppbar({super.key, required BuildContext context, required String title})
      : super(
          preferredSize: const Size.fromHeight(72),
          child: Container(
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
            child: Row(
              children: [
                IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Iconsax.arrow_left)),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.dark[100]!,
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(color: AppColors.dark[200]!, width: 2.0),
                  ),
                  child: const Icon(
                    Iconsax.profile_2user5,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        );
}
