import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imposto/constants/theme_colors.dart';
import 'package:imposto/shared/icons_list.dart';

class ProfileIcon extends StatelessWidget {
  final int iconId;
  final VoidCallback? onTap;
  final bool? selected;
  final bool? isSmall;
  const ProfileIcon({
    super.key,
    required this.iconId,
    this.onTap,
    this.selected,
    this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    final String icon = iconsList[iconId] as String;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: ThemeColors.zinc800,
          borderRadius: BorderRadius.circular(999),
          // boxShadow: BoxShadow,
          border: Border.all(
            color: selected != null && selected == true
                ? ThemeColors.primary700
                : ThemeColors.zinc700,
            width: 2.5,
          ),
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(999),

          child: Image.asset(
            'lib/assets/avatars/$icon',
            width: isSmall != null && isSmall == true ? 28 : 74,
            height: isSmall != null && isSmall == true ? 28 : 74,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
