import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:podcast_app_ui/constants/number_constant.dart';
import 'package:podcast_app_ui/constants/string_const.dart';
import 'package:podcast_app_ui/core/app_colors.dart';
import 'package:podcast_app_ui/core/app_data.dart';
import 'package:podcast_app_ui/core/app_textstyles.dart';
import 'package:podcast_app_ui/core/asset_res.dart';
import 'package:podcast_app_ui/presentation/providers/player_provider.dart';
import 'package:podcast_app_ui/presentation/widgets/circle_icon_button.dart';
import 'package:podcast_app_ui/presentation/widgets/dotted_scaffold_background.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  static const _waveformHeights = [
    0.51, 0.87, 0.74, 0.38, 0.51, 0.18, 0.44, 0.64, 0.41, 1.0, 0.93, 0.74, 0.38, 0.64, 0.51, 0.28, 0.44, 0.64, 0.93, 0.74, 0.51, 0.64, 0.93, 0.51, 0.41, 0.64, 0.28, 0.51,
    0.87, 0.74, 0.51, 0.31, 0.51, 0.11, 0.51, 0.64, 0.31, 0.87, 0.64, 0.44, 0.31, 0.64, 0.51, 0.18, 0.31, 0.44, 0.64, 0.51, 0.44, 0.64, 0.44, 0.64, 0.51, 0.44, 0.31, 0.44,
  ];

  @override
  Widget build(BuildContext context) {
    final track = AppData.nowPlaying;
    return DottedScaffoldBackground(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: SafeArea(
          child: Padding(
            padding: .fromLTRB(
              NumberConstant.horizontalPadding,
              NumberConstant.screenTopPadding,
              NumberConstant.horizontalPadding,
              NumberConstant.playerBottomPadding,
            ),
            child: Column(
              spacing: NumberConstant.playerSectionGap,
              children: [
                _buildTopBar(context),
                Expanded(child: _buildAlbumArt(track.cover)),
                _buildTrackInfo(track.title, track.artist),
                _buildWaveform(context),
                _buildControls(context),
                _buildLyricsButton(),
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
              Text(StringConst.nowPlaying, style: AppTextStyles.screenTitle, textAlign: .center),
              SvgPicture.asset(AssetRes.titleUnderline),
            ],
          ),
        ),
        Consumer<PlayerProvider>(
          builder: (context, player, _) => CircleIconButton(
            iconPath: AssetRes.icFavorite,
            backgroundColor: AppColors.transparent,
            iconColor: player.isFavorite ? AppColors.primaryLime : AppColors.blackColor,
            onTap: player.toggleFavorite,
          ),
        ),
      ],
    );
  }

  Widget _buildAlbumArt(String cover) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest.shortestSide * 0.92;
        return Center(
          child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              alignment: .center,
              clipBehavior: .none,
              children: [
                Positioned(right: -4, top: 8, child: SvgPicture.asset(AssetRes.avatarDots)),
                Transform.rotate(
                  angle: NumberConstant.playerAlbumRotation,
                  child: Container(
                    width: size - NumberConstant.playerAlbumOffset,
                    height: size - NumberConstant.playerAlbumOffset,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLime,
                      borderRadius: .circular(NumberConstant.playerAlbumRadius),
                      border: .all(color: AppColors.blackColor, width: NumberConstant.landingButtonBorderWidth),
                    ),
                  ),
                ),
                Container(
                  width: size - NumberConstant.playerAlbumOffset * 2,
                  height: size - NumberConstant.playerAlbumOffset * 2,
                  decoration: BoxDecoration(
                    borderRadius: .circular(NumberConstant.playerAlbumRadius),
                    border: .all(color: AppColors.blackColor, width: NumberConstant.landingButtonBorderWidth),
                  ),
                  clipBehavior: .hardEdge,
                  child: Image.asset(cover, fit: .cover),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrackInfo(String title, String artist) {
    return Column(
      spacing: NumberConstant.playerTitleGap,
      children: [
        Text(title, style: AppTextStyles.trackTitle, textAlign: .center),
        Text(artist, style: AppTextStyles.trackArtist, textAlign: .center),
      ],
    );
  }

  Widget _buildWaveform(BuildContext context) {
    return SizedBox(
      height: NumberConstant.playerWaveformHeight,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final barSlot = NumberConstant.waveformBarWidth + NumberConstant.waveformBarGap;
          final barCount = (constraints.maxWidth / barSlot).floor().clamp(24, _waveformHeights.length);
          final progressCount = (barCount * NumberConstant.playerProgressRatio).round();
          return Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .center,
            children: [
              for (var i = 0; i < barCount; i++)
                Container(
                  width: NumberConstant.waveformBarWidth,
                  height: NumberConstant.playerWaveformHeight * _waveformHeights[i % _waveformHeights.length],
                  decoration: BoxDecoration(
                    color: i < progressCount ? AppColors.primaryLime : AppColors.waveformGray,
                    borderRadius: .circular(NumberConstant.waveformBarWidth),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildControls(BuildContext context) {
    return FittedBox(
      fit: .scaleDown,
      child: Row(
        mainAxisAlignment: .center,
        spacing: NumberConstant.playerControlsGap,
        children: [
          SvgPicture.asset(AssetRes.icRepeat, colorFilter: .mode(AppColors.blackColor, .srcIn)),
          SvgPicture.asset(AssetRes.icPrevPlayback, colorFilter: .mode(AppColors.blackColor, .srcIn)),
          Consumer<PlayerProvider>(
            builder: (context, player, _) => GestureDetector(
              onTap: player.togglePlaying,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: .circular(NumberConstant.playerPlayButtonRadius),
                  border: .all(color: AppColors.blackColor, width: NumberConstant.playerPlayBorderWidth),
                ),
                child: Padding(
                  padding: .all(NumberConstant.playerPlayButtonPadding),
                  child: SvgPicture.asset(AssetRes.icPlay, colorFilter: .mode(AppColors.blackColor, .srcIn)),
                ),
              ),
            ),
          ),
          SvgPicture.asset(AssetRes.icPlaybackNext, colorFilter: .mode(AppColors.blackColor, .srcIn)),
          SvgPicture.asset(AssetRes.icMore, colorFilter: .mode(AppColors.blackColor, .srcIn)),
        ],
      ),
    );
  }

  Widget _buildLyricsButton() {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.primaryLime,
          borderRadius: .circular(NumberConstant.lyricsButtonRadius),
          border: .all(color: AppColors.whiteColor, width: NumberConstant.landingButtonBorderWidth),
        ),
        child: Padding(
          padding: .symmetric(horizontal: NumberConstant.playerLyricsHorizontalPadding, vertical: NumberConstant.playerLyricsVerticalPadding),
          child: Text(StringConst.viewLyrics, style: AppTextStyles.lyricsButton),
        ),
      ),
    );
  }
}
