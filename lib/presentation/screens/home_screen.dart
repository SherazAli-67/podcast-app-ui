import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podcast_app_ui/constants/string_const.dart';
import 'package:podcast_app_ui/core/app_colors.dart';
import 'package:podcast_app_ui/presentation/providers/home_nav_provider.dart';
import 'package:podcast_app_ui/presentation/widgets/app_bottom_nav.dart';
import 'package:podcast_app_ui/presentation/widgets/dotted_scaffold_background.dart';
import 'package:podcast_app_ui/routing/router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedScaffoldBackground(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Center(
          child: Column(
            mainAxisSize: .min,
            spacing: 16,
            children: [
              Text(StringConst.navHome),
              TextButton(onPressed: () => context.push(NamedRoutes.player.routeName), child: Text(StringConst.nowPlaying)),
              TextButton(onPressed: () => context.push(NamedRoutes.popularList.routeName), child: Text(StringConst.popularList)),
            ],
          ),
        ),
        bottomNavigationBar: Consumer<HomeNavProvider>(
          builder: (context, nav, _) => AppBottomNav(selectedIndex: nav.selectedIndex, onSelected: nav.select),
        ),
      ),
    );
  }
}
