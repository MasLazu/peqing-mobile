import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/presentation/widgets/appbars/root_appbar.dart';

class LecturerSubjectScreen extends StatefulWidget {
  const LecturerSubjectScreen({super.key});

  @override
  State<LecturerSubjectScreen> createState() => LecturerSubjectScreenState();
}

class LecturerSubjectScreenState extends State<LecturerSubjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RootAppbar(title: 'Riwayat', context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: SafeArea(
            child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          shrinkWrap: true,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: 1.2,
          padding: const EdgeInsets.only(bottom: 24.0),
          children: [_buildCivitasCard()],
        )),
      ),
    );
  }

  Widget _buildCivitasCard() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.dark[100]!)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MenuAnchor(
              style: MenuStyle(
                elevation: WidgetStateProperty.all(0.0),
                backgroundColor: WidgetStateProperty.all(Colors.transparent),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16))),
              ),
              menuChildren: <Widget>[
                Container(
                    width: 70,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        color: AppColors.danger[500],
                        borderRadius: BorderRadius.circular(99)),
                    child: Center(
                        child: Text('Hapus',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppColors.white)))),
                Container(
                    width: 70,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        color: AppColors.secondary[500],
                        borderRadius: BorderRadius.circular(99)),
                    child: Center(
                        child: Text('Edit',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppColors.white)))),
              ],
              builder: (BuildContext context, MenuController controller,
                      Widget? child) =>
                  GestureDetector(
                onTap: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(9.33),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(color: AppColors.dark[100]!)),
                  child: Icon(
                    Iconsax.more_circle5,
                    color: AppColors.dark[500]!,
                    size: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Workshop Flutter',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text('Fulan bin Fulan',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
