import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:podcast_app_ui/constants/number_constant.dart';
import 'package:podcast_app_ui/constants/string_const.dart';
import 'package:podcast_app_ui/core/app_colors.dart';
import 'package:podcast_app_ui/core/app_textstyles.dart';
import 'package:podcast_app_ui/core/asset_res.dart';

class AppBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const AppBottomNav({super.key, required this.selectedIndex, required this.onSelected});

  static const _items = [
    (icon: AssetRes.icHome, label: StringConst.navHome),
    (icon: AssetRes.icExplore, label: StringConst.navExplore),
    (icon: AssetRes.icFavorites, label: StringConst.navFavourites),
    (icon: AssetRes.icSettings, label: StringConst.navSearch),
  ];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        border: Border(top: BorderSide(color: AppColors.borderGray)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: .fromLTRB(
            NumberConstant.bottomNavHorizontalPadding,
            NumberConstant.bottomNavTopPadding,
            NumberConstant.bottomNavHorizontalPadding,
            NumberConstant.bottomNavBottomPadding,
          ),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              for (var i = 0; i < _items.length; i++)
                GestureDetector(
                  onTap: () => onSelected(i),
                  behavior: .opaque,
                  child: Column(
                    mainAxisSize: .min,
                    spacing: NumberConstant.bottomNavItemGap,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: selectedIndex == i ? AppColors.primaryLime : AppColors.whiteColor,
                          shape: .circle,
                          border: selectedIndex == i ? null : .all(color: AppColors.blackColor, width: NumberConstant.borderWidth),
                        ),
                        child: Padding(
                          padding: .all(selectedIndex == i ? NumberConstant.selectedNavCirclePadding : NumberConstant.unselectedNavCirclePadding),
                          child: SvgPicture.asset(_items[i].icon, colorFilter: .mode(AppColors.blackColor, .srcIn)),
                        ),
                      ),
                      Text(_items[i].label, style: AppTextStyles.navLabel),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
