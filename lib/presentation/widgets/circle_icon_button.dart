import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:podcast_app_ui/constants/number_constant.dart';
import 'package:podcast_app_ui/core/app_colors.dart';

class CircleIconButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color iconColor;
  final Color? borderColor;
  final EdgeInsetsGeometry padding;

  const CircleIconButton({
    super.key,
    required this.iconPath,
    this.onTap,
    this.backgroundColor = AppColors.blackColor,
    this.iconColor = AppColors.whiteColor,
    this.borderColor,
    this.padding = const .all(NumberConstant.circleActionPadding),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: .circle,
          border: borderColor == null ? null : .all(color: borderColor!, width: NumberConstant.borderWidth),
        ),
        child: Padding(
          padding: padding,
          child: SvgPicture.asset(iconPath, colorFilter: .mode(iconColor, .srcIn)),
        ),
      ),
    );
  }
}
