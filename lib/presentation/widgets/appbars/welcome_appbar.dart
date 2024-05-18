import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/data/models/user.dart';

class WelcomeAppbar extends PreferredSize {
  WelcomeAppbar(BuildContext context, {super.key})
      : super(
          preferredSize: const Size.fromHeight(72),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              var user = (state as Authenticated).auth.user;

              return Container(
                color: AppColors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Halo ${User.roleToString(user.role)},',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            user.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.dark[100]!,
                        borderRadius: BorderRadius.circular(99),
                        border:
                            Border.all(color: AppColors.dark[200]!, width: 2.0),
                      ),
                      child: const Icon(
                        Iconsax.profile_2user5,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
}
