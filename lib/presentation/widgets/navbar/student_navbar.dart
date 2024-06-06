import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/route/route_names.dart';

class StudentNavbar extends StatelessWidget {
  final Widget page;
  final GoRouterState state;

  final List<String> routes = [
    RouteNames.studentHome,
    RouteNames.studentSubject,
    RouteNames.studentProfile,
  ];

  StudentNavbar({super.key, required this.page, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (i) => context.go(routes[i]),
        selectedIndex: routes.indexWhere((route) => route == state.fullPath),
        indicatorColor: AppColors.primary[400]!,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: const Icon(Iconsax.home_15),
            icon: Icon(Iconsax.home_15, color: AppColors.dark[300]),
            label: 'Beranda',
          ),
          NavigationDestination(
            selectedIcon: const Icon(Iconsax.clipboard_text5),
            icon: Icon(Iconsax.clipboard_text5, color: AppColors.dark[300]!),
            label: 'Mata Kuliah',
          ),
          NavigationDestination(
            selectedIcon: const Icon(Iconsax.profile_2user5),
            icon: Icon(Iconsax.profile_2user5, color: AppColors.dark[300]!),
            label: 'Profil',
          ),
        ],
      ),
      body: SafeArea(child: page),
    );
  }
}
