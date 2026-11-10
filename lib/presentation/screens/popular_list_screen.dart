import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:podcast_app_ui/constants/number_constant.dart';
import 'package:podcast_app_ui/constants/string_const.dart';
import 'package:podcast_app_ui/core/app_colors.dart';
import 'package:podcast_app_ui/core/app_data.dart';
import 'package:podcast_app_ui/core/app_textstyles.dart';
import 'package:podcast_app_ui/core/asset_res.dart';
import 'package:podcast_app_ui/core/models/episode_model.dart';
import 'package:podcast_app_ui/presentation/widgets/circle_icon_button.dart';
import 'package:podcast_app_ui/presentation/widgets/dotted_scaffold_background.dart';
import 'package:podcast_app_ui/presentation/widgets/staggered_pressable.dart';
import 'package:podcast_app_ui/routing/router.dart';

class PopularListScreen extends StatelessWidget {
  const PopularListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedScaffoldBackground(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: SafeArea(
          child: Padding(
            padding: .fromLTRB(
              NumberConstant.horizontalPadding,
              NumberConstant.screenTopPadding,
              NumberConstant.horizontalPadding,
              0,
            ),
            child: Column(
              spacing: NumberConstant.sectionGap,
              children: [
                _buildTopBar(context),
                Expanded(
                  child: ListView.separated(
                    padding: .only(bottom: NumberConstant.listBottomPadding),
                    itemCount: AppData.popularEpisodes.length,
                    separatorBuilder: (_, _) => const SizedBox(height: NumberConstant.episodeRowGap),
                    itemBuilder: (context, index) => StaggeredPressable(
                      index: index,
                      onTap: () => context.push(NamedRoutes.player.routeName),
                      child: _buildEpisodeRow(AppData.popularEpisodes[index], showPlay: index != 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        CircleIconButton(iconPath: AssetRes.icArrowBack, onTap: () => context.pop()),
        Expanded(
          child: Column(
            children: [
              Text(StringConst.popularList, style: AppTextStyles.screenTitle, textAlign: .center),
              SvgPicture.asset(AssetRes.titleUnderline),
            ],
          ),
        ),
        CircleIconButton(iconPath: AssetRes.icFavorite, backgroundColor: AppColors.transparent, iconColor: AppColors.blackColor),
      ],
    );
  }

  Widget _buildEpisodeRow(EpisodeModel episode, {required bool showPlay}) {
    return Row(
      spacing: NumberConstant.episodeContentGap,
      children: [
        ClipRRect(
          borderRadius: .circular(NumberConstant.episodeThumbRadius),
          child: Image.asset(
            episode.cover,
            width: NumberConstant.episodeThumbSize,
            height: NumberConstant.episodeThumbSize,
            fit: .cover,
          ),
        ),
        Expanded(
          child: Column(
            spacing: NumberConstant.episodeMetaGap,
            crossAxisAlignment: .start,
            children: [
              Text(episode.title, style: AppTextStyles.episodeTitle, maxLines: 1, overflow: .ellipsis),
              Row(
                spacing: NumberConstant.episodeMetaGap,
                children: [
                  Flexible(
                    child: Opacity(
                      opacity: 0.7,
                      child: Text(episode.author, style: AppTextStyles.episodeMeta, maxLines: 1, overflow: .ellipsis),
                    ),
                  ),
                  Container(
                    width: NumberConstant.episodeMetaDotSize,
                    height: NumberConstant.episodeMetaDotSize,
                    decoration: BoxDecoration(color: AppColors.darkGrayText.withValues(alpha: 0.7), shape: .circle),
                  ),
                  Opacity(
                    opacity: 0.7,
                    child: Text(episode.episodeLabel, style: AppTextStyles.episodeMeta, maxLines: 1, overflow: .ellipsis),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: .min,
          spacing: NumberConstant.episodeActionsGap,
          children: [
            if (showPlay && !episode.isActive) SvgPicture.asset(AssetRes.icPlaycircleRounded),
            _buildMoreAction(episode.isActive),
          ],
        ),
      ],
    );
  }

  Widget _buildMoreAction(bool isActive) {
    final icon =  SvgPicture.asset(AssetRes.icMore, colorFilter: .mode(AppColors.darkGrayText, .srcIn));

    if (!isActive) return icon;
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: .circle,
        border: .all(color: AppColors.borderGray, width: NumberConstant.borderWidth),
      ),
      child: Padding(padding: .all(NumberConstant.episodeActiveMorePadding), child: icon),
    );
  }
}
