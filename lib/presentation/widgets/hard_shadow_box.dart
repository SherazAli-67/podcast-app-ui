import 'package:flutter/material.dart';
import 'package:podcast_app_ui/constants/number_constant.dart';
import 'package:podcast_app_ui/core/app_colors.dart';

class HardShadowBox extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final double shadowOffset;
  final Clip clipBehavior;

  const HardShadowBox({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = NumberConstant.cardRadius,
    this.color = AppColors.whiteColor,
    this.borderColor = AppColors.blackColor,
    this.borderWidth = NumberConstant.borderWidth,
    this.shadowOffset = NumberConstant.hardShadowOffset,
    this.clipBehavior = .none,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: clipBehavior,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: .circular(borderRadius),
        border: .all(color: borderColor, width: borderWidth),
        boxShadow: [BoxShadow(color: AppColors.shadowBlack, offset: Offset(shadowOffset, shadowOffset), blurRadius: 0)],
      ),
      child: child,
    );
  }
}
