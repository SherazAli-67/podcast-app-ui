import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podcast_app_ui/constants/string_const.dart';
import 'package:podcast_app_ui/routing/router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () => context.go(NamedRoutes.home.routeName),
          child: Text(StringConst.signUp),
        ),
      ),
    );
  }
}
