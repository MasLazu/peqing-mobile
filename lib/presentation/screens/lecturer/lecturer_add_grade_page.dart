import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:peqing/core/theme/app_colors.dart';
import 'package:peqing/presentation/widgets/buttons/peqing_button.dart';
import 'package:peqing/presentation/widgets/peqing_appbar.dart';
import 'package:peqing/presentation/widgets/peqing_textfield.dart';
import 'package:peqing/route/route_names.dart';

class LecturerAddGradePage extends StatelessWidget {
  const LecturerAddGradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PeqingAppbar(
          leadingOnPressed: () {
            context.go(RouteNames.lecturerHome);
          },
          title: Center(
            child: Text(
              'Kasih Nilai',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Icon(
                  Iconsax.profile_circle5,
                  size: 40,
                  color: AppColors.dark[100],
                )),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          margin: const EdgeInsets.only(top: 24, bottom: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _buildAksiCepatProfile(context),
                  const SizedBox(height: 24),
                  _buildPilihMataKuliah(context),
                  const SizedBox(height: 24),
                  _buildRadioButton(context),
                  const SizedBox(height: 24),
                  _buildBeriNilai(context),
                ],
              ),
              const Spacer(),
              PeqingButton(text: 'Simpan dan Beri Nilai', onPressed: () {}),
            ],
          ),
        ));
  }

  Column _buildBeriNilai(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Beri Nilai',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const PeqingTextfield(
          text: 'Masukkan nilai',
        ),
      ],
    );
  }

  Column _buildRadioButton(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Pilih Penugasan',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            GestureDetector(
                onTap: () {},
                child: Text('Tambah',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary[500]!))),
          ],
        ),
        const SizedBox(height: 16),
        CupertinoRadioChoice(
          choices: const {
            'tugas1': 'Tugas 1',
            'tugas2': 'Tugas 2',
            'uts': 'UTS',
            'uas': 'UAS'
          },
          onChange: (value) {},
          initialKeyValue: 'uts',
          selectedColor: AppColors.primary[500]!,
          notSelectedColor: AppColors.dark[100]!,
        ),
      ],
    );
  }

  DropdownButtonFormField<String> _buildPilihMataKuliah(BuildContext context) {
    return DropdownButtonFormField(
      items: [
        DropdownMenuItem(
            value: 'Pemrograman Mobile',
            child: Text('Pemrograman Mobile',
                style: Theme.of(context).textTheme.bodyMedium)),
        DropdownMenuItem(
            value: 'Pemrograman Web',
            child: Text('Pemrograman Web',
                style: Theme.of(context).textTheme.bodyMedium)),
        DropdownMenuItem(
            value: 'Pemrograman Desktop',
            child: Text('Pemrograman Desktop',
                style: Theme.of(context).textTheme.bodyMedium)),
      ],
      onChanged: (value) {},
      hint: Text('Pilih Mata Kuliah',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.bold)),
      icon: Icon(
        Iconsax.arrow_down_1,
        color: AppColors.dark[500],
        size: 16,
      ),
    );
  }

  Widget _buildAksiCepatProfile(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.dark[100]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.profile_circle5,
                size: 40,
                color: AppColors.dark[100],
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fulan bin Fulan',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text('2 D4 IT A',
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                side: BorderSide(color: AppColors.primary[500]!),
              ),
              onPressed: () {},
              child: Text('Ganti',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary[500]))),
        ],
      ),
    );
  }
}
