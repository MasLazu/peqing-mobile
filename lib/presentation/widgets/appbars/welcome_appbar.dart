import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/core/theme/app_colors.dart';

class WelcomeAppbar extends PreferredSize {
  WelcomeAppbar(BuildContext context, {super.key})
      : super(
          preferredSize: const Size.fromHeight(72),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              var user = (state as AuthAuthenticated).data;

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
                            'Halo ${user.role},',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            user.user!.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Iconsax.profile_circle5,
                      size: 48,
                      color: AppColors.dark[100],
                    ),
                  ],
                ),
              );
            },
          ),
        );
}
