import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podcast_app_ui/constants/number_constant.dart';
import 'package:podcast_app_ui/constants/string_const.dart';
import 'package:podcast_app_ui/core/app_colors.dart';
import 'package:podcast_app_ui/core/app_data.dart';
import 'package:podcast_app_ui/core/asset_res.dart';
import 'package:podcast_app_ui/presentation/widgets/circle_icon_button.dart';
import 'package:podcast_app_ui/presentation/widgets/dotted_scaffold_background.dart';
import 'package:podcast_app_ui/routing/router.dart';

class PopularListScreen extends StatelessWidget {
  const PopularListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedScaffoldBackground(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: SafeArea(
          child: Column(
            spacing: 16,
            children: [
              Padding(
                padding: .symmetric(horizontal: NumberConstant.horizontalPadding),
                child: Row(
                  children: [
                    CircleIconButton(iconPath: AssetRes.icArrowBack, onTap: () => context.pop()),
                    Expanded(child: Text(StringConst.popularList, textAlign: .center)),
                    CircleIconButton(iconPath: AssetRes.icFavorite, backgroundColor: AppColors.transparent, iconColor: AppColors.blackColor),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: AppData.popularEpisodes.length,
                  itemBuilder: (context, index) {
                    final episode = AppData.popularEpisodes[index];
                    return ListTile(
                      title: Text(episode.title),
                      subtitle: Text('${episode.author} · ${episode.episodeLabel}'),
                      onTap: () => context.push(NamedRoutes.player.routeName),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
