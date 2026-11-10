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
                  //goodMorning, homeGreeting,
                  //morningDivider
                ],
              ),
              //letsPlayMusic, homeSubtitle
            ],
          ),
        ),
        Stack(
          alignment: .center,
          clipBehavior: .none,
          children: [

            //svg: avatarDots
            Positioned(right: 28, top: -10, child: const SizedBox()),
            //profileAvatar, widthHeight: avatarSize, fit.cover
            ClipOval(child: const SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return SizedBox();
    /*return HardShadowBox(
      padding: .symmetric(horizontal: NumberConstant.searchFieldPadding, vertical: NumberConstant.searchFieldPadding),
      child: Row(
        spacing: NumberConstant.searchRowGap,
        children: [
          //icSearch
          //searchHint, searchHint
          Expanded(child: const SizedBox()),
        ],
      ),
    );*/
  }

  Widget _buildStoriesSection(BuildContext context, double storyWidth) {
    return Column(
      spacing: NumberConstant.sectionHeaderGap,
      children: [
        // SectionHeader(title: StringConst.stories, actionLabel: StringConst.viewAll, onActionTap: () => context.push(NamedRoutes.popularList.routeName)),
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
    return SizedBox();
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
                //icStoryRing,
                //story.image, widthHeight: storyImageSize, fit.cover
                ClipOval(child: const SizedBox()),
              ],
            ),
            //story.title, style: cardTitle, textAlign.center

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
       /* SectionHeader(
          title: StringConst.recentlyPlayed,
          actionLabel: StringConst.viewMore,
          onActionTap: () => context.push(NamedRoutes.popularList.routeName),
          titleTrailing: SvgPicture.asset(AssetRes.icAiStar),
        ),*/
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
            /*AspectRatio(
              aspectRatio: NumberConstant.albumAspectRatio,
              child: HardShadowBox(
                borderRadius: NumberConstant.albumRadius,
                clipBehavior: .hardEdge,
                child: Stack(
                  fit: .expand,
                  children: [
                    //album.cover, fit.cover
                    Positioned(
                      right: NumberConstant.albumPlayInset,
                      bottom: NumberConstant.albumPlayInset,
                      //icPlayCircleRounded
                      child: const SizedBox()
                    ),
                  ],
                ),
              ),
            ),*/
            //album.title, cardTitle, textAlign.center, maxLines: 2
          ],
        ),
      ),
    );
  }

  Widget _buildMoodsSection(BuildContext context, double cardWidth) {
    return Column(
      spacing: NumberConstant.sectionHeaderGap,
      children: [
        // SectionHeader(title: StringConst.moodsAndGenres, actionLabel: StringConst.viewMore, onActionTap: () => context.push(NamedRoutes.popularList.routeName)),
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
    return SizedBox();
   /* return SizedBox(
      width: width,
      child: HardShadowBox(
        borderRadius: NumberConstant.albumRadius,
        clipBehavior: .hardEdge,
        child: Image.asset(mood.cover, fit: .cover, width: width, height: width),
      ),
    );*/
  }
}
