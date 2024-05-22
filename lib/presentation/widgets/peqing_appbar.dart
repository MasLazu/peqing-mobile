import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PeqingAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const PeqingAppbar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackIcon = true,
    this.backgroundColor = Colors.white,
  });

  final Widget? title;
  final List<Widget>? actions;
  final IconData? leadingIcon;
  final VoidCallback? leadingOnPressed;
  final bool showBackIcon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight + 24,
      titleSpacing: 24,
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 16,
      shadowColor: const Color(0xFF292D32).withOpacity(0.04),
      automaticallyImplyLeading: false,
      leading: showBackIcon
          ? Padding(
            padding: const EdgeInsets.only(left: 16),
            child: IconButton(
                icon: Icon(leadingIcon ?? Iconsax.arrow_left),
                onPressed:
                  leadingOnPressed ?? () => Navigator.of(context).pop(),
              ),
          )
          : leadingIcon != null
              ? IconButton(
                  onPressed: leadingOnPressed,
                  icon: Icon(leadingIcon),
                )
              : null,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 24);
}
