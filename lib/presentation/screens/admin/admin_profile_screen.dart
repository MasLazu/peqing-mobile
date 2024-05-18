import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/presentation/widgets/appbars/root_appbar.dart';
import 'package:peqing/presentation/widgets/buttons/peqing_outline_button.dart';
import 'package:peqing/route/route_names.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RootAppbar(title: 'Profil', context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.dark[100]!,
                        borderRadius: BorderRadius.circular(99),
                        border:
                            Border.all(color: AppColors.dark[200]!, width: 2.0),
                      ),
                      child: const Icon(
                        Iconsax.profile_2user5,
                        size: 34,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        var user = (state as Authenticated).auth.user;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(user.id,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () => Clipboard.setData(
                                      ClipboardData(text: user.id)),
                                  child: Icon(
                                    Iconsax.copy5,
                                    size: 16,
                                    color: AppColors.dark[500]!,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(height: 24.0),
                PeqingOutlineButton(
                  text: 'Buat Data Manual',
                  onPressed: () {},
                  align: Alignment.centerLeft,
                  icon: Iconsax.keyboard5,
                ),
                const SizedBox(height: 12.0),
                PeqingOutlineButton(
                  text: 'Unggah via CSV',
                  onPressed: () {},
                  align: Alignment.centerLeft,
                  icon: Iconsax.document5,
                ),
                const SizedBox(height: 12.0),
                PeqingOutlineButton(
                  text: 'Lihat Civitas PENS',
                  onPressed: () {
                    context.go(RouteNames.adminCivitas);
                  },
                  align: Alignment.centerLeft,
                  icon: Iconsax.people5,
                ),
                const SizedBox(height: 12.0),
                PeqingOutlineButton(
                  text: 'Logout',
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(LogoutAuth(context));
                  },
                  align: Alignment.centerLeft,
                  icon: Iconsax.logout_15,
                  color: AppColors.danger[500],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
