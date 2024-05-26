import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/core/theme/app_colors.dart';

class RootAppbar extends PreferredSize {
  RootAppbar(
      {super.key,
      required BuildContext context,
      required String title,
      Widget? bottom})
      : super(
          preferredSize: Size.fromHeight(bottom == null ? 72 : 120),
          child: Container(
            color: AppColors.white,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/peqing-icon.svg'),
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Icon(
                        Iconsax.profile_circle5,
                        size: 48,
                        color: AppColors.dark[100],
                      ),
                    ],
                  ),
                ),
                if (bottom != null) bottom,
              ],
            ),
          ),
        );
}
