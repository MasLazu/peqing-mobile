import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/route/route_names.dart';

class AdminNavbar extends StatelessWidget {
  final Widget page;
  final GoRouterState state;

  final List<String> routes = [
    RouteNames.adminHome,
    RouteNames.adminCivitas,
    RouteNames.adminHistory,
    RouteNames.adminProfile,
  ];

  AdminNavbar({super.key, required this.page, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (i) => context.go(routes[i]),
        selectedIndex: routes.indexWhere((route) => route == state.fullPath),
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: const Icon(Iconsax.home_15),
            icon: Icon(Iconsax.home_15, color: AppColors.dark[300]),
            label: 'Beranda',
          ),
          NavigationDestination(
            selectedIcon: const Icon(Iconsax.people5),
            icon: Icon(Iconsax.people5, color: AppColors.dark[300]!),
            label: 'Daftar Civitas',
          ),
          NavigationDestination(
            selectedIcon: const Icon(Iconsax.clock5),
            icon: Icon(Iconsax.clock5, color: AppColors.dark[300]!),
            label: 'Riwayat',
          ),
          NavigationDestination(
            selectedIcon: const Icon(Iconsax.profile_2user5),
            icon: Icon(Iconsax.profile_2user5, color: AppColors.dark[300]!),
            label: 'Profil',
          ),
        ],
      ),
      body: page,
    );
  }
}