import 'dart:math' as math;

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
                Expanded(child: _PlayerAlbumArt(cover: track.cover)),
                _buildTrackInfo(track.title, track.artist),
                const _PlayerWaveform(),
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
          builder: (context, player, _) => AnimatedScale(
            scale: player.isFavorite ? NumberConstant.playerFavoriteScale : 1,
            duration: const Duration(milliseconds: NumberConstant.playerControlAnimMs),
            curve: Curves.easeOutBack,
            child: CircleIconButton(
              iconPath: AssetRes.icFavorite,
              backgroundColor: AppColors.transparent,
              iconColor: player.isFavorite ? AppColors.primaryLime : AppColors.blackColor,
              onTap: player.toggleFavorite,
            ),
          ),
        ),
      ],
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

  Widget _buildControls(BuildContext context) {
    return FittedBox(
      fit: .scaleDown,
      child: Row(
        mainAxisAlignment: .center,
        spacing: NumberConstant.playerControlsGap,
        children: [
          SvgPicture.asset(AssetRes.icRepeat, colorFilter: .mode(AppColors.blackColor, .srcIn)),
          SvgPicture.asset(AssetRes.icPrevPlayback, colorFilter: .mode(AppColors.blackColor, .srcIn)),
          const _PlayControl(),
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

class _PlayControl extends StatelessWidget {
  const _PlayControl();

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(
      builder: (context, player, _) {
        return GestureDetector(
          onTap: player.togglePlaying,
          child: AnimatedScale(
            scale: player.isPlaying ? NumberConstant.playerPlayScale : 1,
            duration: const Duration(milliseconds: NumberConstant.playerControlAnimMs),
            curve: Curves.easeOutCubic,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: .circular(NumberConstant.playerPlayButtonRadius),
                border: .all(color: AppColors.blackColor, width: NumberConstant.playerPlayBorderWidth),
              ),
              child: Padding(
                padding: .all(NumberConstant.playerPlayButtonPadding),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: NumberConstant.playerControlAnimMs),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: SizedBox(
                    key: ValueKey(player.isPlaying ? 'pause' : 'play'),
                    width: NumberConstant.playerPauseIconSize,
                    height: NumberConstant.playerPauseIconSize,
                    child: player.isPlaying
                        ? const _PauseIcon()
                        : SvgPicture.asset(
                            AssetRes.icPlay,
                            colorFilter: .mode(AppColors.blackColor, .srcIn),
                          ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PauseIcon extends StatelessWidget {
  const _PauseIcon();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      spacing: 4,
      children: [
        Container(
          width: 5,
          height: NumberConstant.playerPauseIconSize * 0.7,
          decoration: BoxDecoration(
            color: AppColors.blackColor,
            borderRadius: .circular(1.5),
          ),
        ),
        Container(
          width: 5,
          height: NumberConstant.playerPauseIconSize * 0.7,
          decoration: BoxDecoration(
            color: AppColors.blackColor,
            borderRadius: .circular(1.5),
          ),
        ),
      ],
    );
  }
}

class _PlayerAlbumArt extends StatefulWidget {
  final String cover;

  const _PlayerAlbumArt({required this.cover});

  @override
  State<_PlayerAlbumArt> createState() => _PlayerAlbumArtState();
}

class _PlayerAlbumArtState extends State<_PlayerAlbumArt> with SingleTickerProviderStateMixin {
  late final AnimationController _breathe;
  PlayerProvider? _player;

  @override
  void initState() {
    super.initState();
    _breathe = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: NumberConstant.playerAlbumBreatheMs),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final player = context.read<PlayerProvider>();
    if (!identical(_player, player)) {
      _player?.removeListener(_syncPlayback);
      _player = player;
      _player!.addListener(_syncPlayback);
      _syncPlayback();
    }
  }

  void _syncPlayback() {
    if (!mounted) return;
    final playing = _player?.isPlaying ?? false;
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    if (disableAnimations || !playing) {
      if (_breathe.isAnimating) {
        _breathe.stop();
        _breathe.value = 0;
      }
      return;
    }
    if (!_breathe.isAnimating) {
      _breathe.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _player?.removeListener(_syncPlayback);
    _breathe.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                AnimatedBuilder(
                  animation: _breathe,
                  builder: (context, child) {
                    final angle = NumberConstant.playerAlbumRotation +
                        (NumberConstant.playerAlbumBreatheDelta * math.sin(_breathe.value * math.pi));
                    return Transform.rotate(angle: angle, child: child);
                  },
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
                  child: Image.asset(widget.cover, fit: .cover),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PlayerWaveform extends StatefulWidget {
  const _PlayerWaveform();

  @override
  State<_PlayerWaveform> createState() => _PlayerWaveformState();
}

class _PlayerWaveformState extends State<_PlayerWaveform> with SingleTickerProviderStateMixin {
  static const _heights = [
    0.51, 0.87, 0.74, 0.38, 0.51, 0.18, 0.44, 0.64, 0.41, 1.0, 0.93, 0.74, 0.38, 0.64, 0.51, 0.28, 0.44, 0.64, 0.93, 0.74, 0.51, 0.64, 0.93, 0.51, 0.41, 0.64, 0.28, 0.51,
    0.87, 0.74, 0.51, 0.31, 0.51, 0.11, 0.51, 0.64, 0.31, 0.87, 0.64, 0.44, 0.31, 0.64, 0.51, 0.18, 0.31, 0.44, 0.64, 0.51, 0.44, 0.64, 0.44, 0.64, 0.51, 0.44, 0.31, 0.44,
  ];

  late final AnimationController _pulse;
  PlayerProvider? _player;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: NumberConstant.playerWaveformLoopMs),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final player = context.read<PlayerProvider>();
    if (!identical(_player, player)) {
      _player?.removeListener(_syncPlayback);
      _player = player;
      _player!.addListener(_syncPlayback);
      _syncPlayback();
    }
  }

  void _syncPlayback() {
    if (!mounted) return;
    final playing = _player?.isPlaying ?? false;
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    if (disableAnimations || !playing) {
      if (_pulse.isAnimating) {
        _pulse.stop();
        _pulse.value = 0;
      }
      return;
    }
    if (!_pulse.isAnimating) {
      _pulse.repeat();
    }
  }

  @override
  void dispose() {
    _player?.removeListener(_syncPlayback);
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: NumberConstant.playerWaveformHeight,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final barSlot = NumberConstant.waveformBarWidth + NumberConstant.waveformBarGap;
          final barCount = (constraints.maxWidth / barSlot).floor().clamp(24, _heights.length);
          final progressCount = (barCount * NumberConstant.playerProgressRatio).round();

          return AnimatedBuilder(
            animation: _pulse,
            builder: (context, _) {
              return Row(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .center,
                children: [
                  for (var i = 0; i < barCount; i++)
                    Container(
                      width: NumberConstant.waveformBarWidth,
                      height: NumberConstant.playerWaveformHeight * _barHeight(i),
                      decoration: BoxDecoration(
                        color: i < progressCount ? AppColors.primaryLime : AppColors.waveformGray,
                        borderRadius: .circular(NumberConstant.waveformBarWidth),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  double _barHeight(int index) {
    final base = _heights[index % _heights.length];
    if (!_pulse.isAnimating) return base;
    final phase = (_pulse.value * math.pi * 2) + (index * 0.45);
    final modulated = base + (math.sin(phase) * NumberConstant.playerWaveformAmp * base);
    return modulated.clamp(0.08, 1.0);
  }
}
