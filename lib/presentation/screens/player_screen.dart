import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podcast_app_ui/constants/number_constant.dart';
import 'package:podcast_app_ui/constants/string_const.dart';
import 'package:podcast_app_ui/core/app_colors.dart';
import 'package:podcast_app_ui/core/app_data.dart';
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
            padding: .symmetric(horizontal: NumberConstant.horizontalPadding),
            child: Column(
              spacing: 16,
              children: [
                Row(
                  children: [
                    CircleIconButton(iconPath: AssetRes.icArrowBack, onTap: () => context.pop()),
                    Expanded(child: Text(StringConst.nowPlaying, textAlign: .center)),
                    Consumer<PlayerProvider>(
                      builder: (context, player, _) => CircleIconButton(
                        iconPath: AssetRes.icFavorite,
                        backgroundColor: AppColors.transparent,
                        iconColor: player.isFavorite ? AppColors.primaryLime : AppColors.blackColor,
                        onTap: player.toggleFavorite,
                      ),
                    ),
                  ],
                ),
                Text(track.title),
                Text(track.artist),
                Consumer<PlayerProvider>(
                  builder: (context, player, _) => IconButton(
                    onPressed: player.togglePlaying,
                    icon: Icon(player.isPlaying ? Icons.pause : Icons.play_arrow),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
