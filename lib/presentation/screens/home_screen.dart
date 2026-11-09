import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:podcast_app_ui/constants/number_constant.dart';
import 'package:podcast_app_ui/constants/string_const.dart';
import 'package:podcast_app_ui/core/app_colors.dart';
import 'package:podcast_app_ui/core/app_data.dart';
import 'package:podcast_app_ui/core/app_textstyles.dart';
import 'package:podcast_app_ui/core/asset_res.dart';
import 'package:podcast_app_ui/core/models/album_model.dart';
import 'package:podcast_app_ui/core/models/mood_genre_model.dart';
import 'package:podcast_app_ui/core/models/story_model.dart';
import 'package:podcast_app_ui/presentation/providers/home_nav_provider.dart';
import 'package:podcast_app_ui/presentation/widgets/app_bottom_nav.dart';
import 'package:podcast_app_ui/presentation/widgets/dotted_scaffold_background.dart';
import 'package:podcast_app_ui/presentation/widgets/hard_shadow_box.dart';
import 'package:podcast_app_ui/presentation/widgets/section_header.dart';
import 'package:podcast_app_ui/routing/router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final contentWidth = screenWidth - (NumberConstant.horizontalPadding * 2);
    final storyWidth = contentWidth * NumberConstant.storyWidthFactor;
    final albumWidth = contentWidth * NumberConstant.albumWidthFactor;

    return DottedScaffoldBackground(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: .fromLTRB(NumberConstant.horizontalPadding, NumberConstant.screenTopPadding, NumberConstant.horizontalPadding, 0),
            child: Column(
              spacing: NumberConstant.sectionGap,
              children: [
                _buildHeader(),
                _buildSearchField(),
                Expanded(
                  child: ListView(
                    padding: .only(bottom: NumberConstant.homeBodyBottomPadding),
                    children: [
                      Column(
                        spacing: NumberConstant.sectionGap,
                        children: [
                          _buildStoriesSection(context, storyWidth),
                          _buildRecentlyPlayedSection(context, albumWidth),
                          _buildMoodsSection(context, albumWidth),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Consumer<HomeNavProvider>(
          builder: (context, nav, _) => AppBottomNav(selectedIndex: nav.selectedIndex, onSelected: nav.select),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: .start,
      children: [
        Expanded(
          child: Column(
            spacing: NumberConstant.homeHeaderGap,
            crossAxisAlignment: .start,
            children: [
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(StringConst.goodMorning, style: AppTextStyles.homeGreeting),
                  SvgPicture.asset(AssetRes.morningDivider),
                ],
              ),
              Text(StringConst.letsPlayMusic, style: AppTextStyles.homeSubtitle),
            ],
          ),
        ),
        Stack(
          alignment: .center,
          clipBehavior: .none,
          children: [
            Positioned(right: -8, top: -10, child: SvgPicture.asset(AssetRes.avatarDots)),
            ClipOval(child: Image.asset(AssetRes.avatarPeep, width: NumberConstant.avatarSize, height: NumberConstant.avatarSize, fit: .cover)),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return HardShadowBox(
      padding: .symmetric(horizontal: NumberConstant.searchFieldPadding, vertical: NumberConstant.searchFieldPadding),
      child: Row(
        spacing: NumberConstant.searchRowGap,
        children: [
          SvgPicture.asset(AssetRes.icSearch, colorFilter: .mode(AppColors.grayText, .srcIn)),
          Expanded(child: Text(StringConst.searchHint, style: AppTextStyles.searchHint, maxLines: 1, overflow: .ellipsis)),
        ],
      ),
    );
  }

  Widget _buildStoriesSection(BuildContext context, double storyWidth) {
    return Column(
      spacing: NumberConstant.sectionHeaderGap,
      children: [
        SectionHeader(title: StringConst.stories, actionLabel: StringConst.viewAll, onActionTap: () => context.push(NamedRoutes.popularList.routeName)),
        SizedBox(
          height: storyWidth / NumberConstant.storyCardAspectRatio,
          child: ListView.separated(
            scrollDirection: .horizontal,
            itemCount: AppData.stories.length,
            separatorBuilder: (_, _) => const SizedBox(width: NumberConstant.storyCardGap),
            itemBuilder: (context, index) => _buildStoryCard(AppData.stories[index], storyWidth),
          ),
        ),
      ],
    );
  }

  Widget _buildStoryCard(StoryModel story, double width) {
    return SizedBox(
      width: width,
      child: HardShadowBox(
        padding: .all(NumberConstant.storyCardPadding),
        child: Column(
          spacing: NumberConstant.storyCardInnerGap,
          mainAxisAlignment: .center,
          children: [
            Stack(
              alignment: .center,
              children: [
                SvgPicture.asset(AssetRes.icStoryRing),
                ClipOval(child: Image.asset(story.image, width: NumberConstant.storyImageSize, height: NumberConstant.storyImageSize, fit: .cover)),
              ],
            ),
            Text(story.title, style: AppTextStyles.cardTitle, textAlign: .center, maxLines: 2, overflow: .ellipsis),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentlyPlayedSection(BuildContext context, double albumWidth) {
    return Column(
      spacing: NumberConstant.sectionHeaderGap,
      crossAxisAlignment: .start,
      children: [
        SectionHeader(
          title: StringConst.recentlyPlayed,
          actionLabel: StringConst.viewMore,
          onActionTap: () => context.push(NamedRoutes.popularList.routeName),
          titleTrailing: SvgPicture.asset(AssetRes.icAiStar),
        ),
        SizedBox(
          height: albumWidth + 44,
          child: ListView.separated(
            scrollDirection: .horizontal,
            itemCount: AppData.recentlyPlayed.length,
            separatorBuilder: (_, _) => const SizedBox(width: NumberConstant.albumCardGap),
            itemBuilder: (context, index) => _buildAlbumCard(context, AppData.recentlyPlayed[index], albumWidth),
          ),
        ),
      ],
    );
  }

  Widget _buildAlbumCard(BuildContext context, AlbumModel album, double width) {
    return GestureDetector(
      onTap: () => context.push(NamedRoutes.player.routeName),
      child: SizedBox(
        width: width,
        child: Column(
          spacing: NumberConstant.albumTitleGap,
          children: [
            AspectRatio(
              aspectRatio: NumberConstant.albumAspectRatio,
              child: HardShadowBox(
                borderRadius: NumberConstant.albumRadius,
                clipBehavior: .hardEdge,
                child: Stack(
                  fit: .expand,
                  children: [
                    Image.asset(album.cover, fit: .cover),
                    Positioned(
                      right: NumberConstant.albumPlayInset,
                      bottom: NumberConstant.albumPlayInset,
                      child: SvgPicture.asset(AssetRes.icPlayCircle),
                    ),
                  ],
                ),
              ),
            ),
            Text(album.title, style: AppTextStyles.cardTitle, textAlign: .center, maxLines: 2, overflow: .ellipsis),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodsSection(BuildContext context, double cardWidth) {
    return Column(
      spacing: NumberConstant.sectionHeaderGap,
      children: [
        SectionHeader(title: StringConst.moodsAndGenres, actionLabel: StringConst.viewMore, onActionTap: () => context.push(NamedRoutes.popularList.routeName)),
        SizedBox(
          height: cardWidth,
          child: ListView.separated(
            scrollDirection: .horizontal,
            itemCount: AppData.moodsAndGenres.length,
            separatorBuilder: (_, _) => const SizedBox(width: NumberConstant.moodCardGap),
            itemBuilder: (context, index) => _buildMoodCard(AppData.moodsAndGenres[index], cardWidth),
          ),
        ),
      ],
    );
  }

  Widget _buildMoodCard(MoodGenreModel mood, double width) {
    return SizedBox(
      width: width,
      child: HardShadowBox(
        borderRadius: NumberConstant.albumRadius,
        clipBehavior: .hardEdge,
        child: Image.asset(mood.cover, fit: .cover, width: width, height: width),
      ),
    );
  }
}
