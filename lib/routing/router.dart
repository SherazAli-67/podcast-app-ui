import 'package:go_router/go_router.dart';
import 'package:podcast_app_ui/presentation/providers/home_nav_provider.dart';
import 'package:podcast_app_ui/presentation/providers/player_provider.dart';
import 'package:podcast_app_ui/presentation/screens/home_screen.dart';
import 'package:podcast_app_ui/presentation/screens/player_screen.dart';
import 'package:podcast_app_ui/presentation/screens/popular_list_screen.dart';
import 'package:podcast_app_ui/presentation/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.home.routeName,
  routes: [
    GoRoute(path: NamedRoutes.welcome.routeName, builder: (ctx, state) => const WelcomeScreen()),
    GoRoute(
      path: NamedRoutes.home.routeName,
      builder: (ctx, state) => ChangeNotifierProvider(create: (_) => HomeNavProvider(), child: const HomeScreen()),
    ),
    GoRoute(
      path: NamedRoutes.player.routeName,
      builder: (ctx, state) => ChangeNotifierProvider(create: (_) => PlayerProvider(), child: const PlayerScreen()),
    ),
    GoRoute(path: NamedRoutes.popularList.routeName, builder: (ctx, state) => const PopularListScreen()),
  ],
);

enum NamedRoutes {
  welcome('/welcome'),
  home('/home'),
  player('/player'),
  popularList('/popular-list');

  final String routeName;
  const NamedRoutes(this.routeName);
}
