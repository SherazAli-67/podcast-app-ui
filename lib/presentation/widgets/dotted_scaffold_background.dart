import 'package:flutter/material.dart';
import 'package:podcast_app_ui/core/app_colors.dart';
import 'package:podcast_app_ui/core/asset_res.dart';

class DottedScaffoldBackground extends StatelessWidget {
  final Widget child;

  const DottedScaffoldBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.creamBackground,
        image: DecorationImage(
          image: AssetImage(AssetRes.scaffoldBgImg),
          fit: .cover,
          opacity: 0.1,
          repeat: .repeat,
        ),
      ),
      child: child,
    );
  }
}
