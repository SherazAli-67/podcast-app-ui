import 'package:flutter/material.dart';
import 'package:podcast_app_ui/core/app_textstyles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String actionLabel;
  final VoidCallback? onActionTap;
  final Widget? titleTrailing;

  const SectionHeader({
    super.key,
    required this.title,
    required this.actionLabel,
    this.onActionTap,
    this.titleTrailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            spacing: 6,
            children: [
              Flexible(child: Text(title, style: AppTextStyles.sectionTitle, maxLines: 1, overflow: .ellipsis)),
              ?titleTrailing,
            ],
          ),
        ),
        GestureDetector(
          onTap: onActionTap,
          child: Text(actionLabel, style: AppTextStyles.sectionAction),
        ),
      ],
    );
  }
}
