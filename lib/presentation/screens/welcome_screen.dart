import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:podcast_app_ui/constants/number_constant.dart';
import 'package:podcast_app_ui/constants/string_const.dart';
import 'package:podcast_app_ui/core/app_colors.dart';
import 'package:podcast_app_ui/core/app_textstyles.dart';
import 'package:podcast_app_ui/core/asset_res.dart';
import 'package:podcast_app_ui/presentation/widgets/dotted_scaffold_background.dart';
import 'package:podcast_app_ui/presentation/widgets/hard_shadow_box.dart';
import 'package:podcast_app_ui/routing/router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DottedScaffoldBackground(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: SafeArea(child: _WelcomeEntrance()),
      ),
    );
  }
}

class _WelcomeEntrance extends StatefulWidget {
  const _WelcomeEntrance();

  @override
  State<_WelcomeEntrance> createState() => _WelcomeEntranceState();
}

class _WelcomeEntranceState extends State<_WelcomeEntrance> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _started = false;

  late final Animation<double> _illustration;
  late final Animation<double> _headline;
  late final Animation<double> _button;
  late final Animation<double> _terms;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: NumberConstant.welcomeEntranceMs),
    );
    _illustration = _interval(0.0, 0.45);
    _headline = _interval(0.22, 0.68);
    _button = _interval(0.42, 0.88);
    _terms = _interval(0.58, 1.0);
  }

  Animation<double> _interval(double begin, double end) {
    return CurvedAnimation(
      parent: _controller,
      curve: Interval(begin, end, curve: Curves.easeOutCubic),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _fadeSlide(
            animation: _illustration,
            child: Image.asset(AssetRes.landingIllustration, fit: .contain, width: double.infinity),
          ),
        ),
        Padding(
          padding: .fromLTRB(
            NumberConstant.horizontalPadding,
            NumberConstant.landingContentTopPadding,
            NumberConstant.horizontalPadding,
            NumberConstant.landingTermsBottomPadding,
          ),
          child: Column(
            spacing: NumberConstant.sectionGap,
            crossAxisAlignment: .stretch,
            children: [
              Column(
                spacing: NumberConstant.landingContentGap,
                crossAxisAlignment: .stretch,
                children: [
                  _fadeSlide(animation: _headline, child: _buildHeadline()),
                  _fadeSlide(animation: _button, child: _buildSignUpButton(context)),
                ],
              ),
              _fadeSlide(
                animation: _terms,
                child: Center(child: Text(StringConst.termsOfUse, style: AppTextStyles.termsLink)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _fadeSlide({required Animation<double> animation, required Widget child}) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, NumberConstant.welcomeSlideOffset),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }

  Widget _buildHeadline() {
    return Stack(
      clipBehavior: .none,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: StringConst.landingHeadlinePrefix, style: AppTextStyles.landingHeadline),
              WidgetSpan(
                alignment: .middle,
                child: Padding(
                  padding: .symmetric(horizontal: 4),
                  child: SvgPicture.asset(AssetRes.icLandingStar),
                ),
              ),
              TextSpan(text: StringConst.landingHeadlineSuffix.trimLeft(), style: AppTextStyles.landingHeadline),
            ],
          ),
        ),
        Positioned(
          right: -8,
          bottom: 0,
          child: Transform.rotate(
            angle: NumberConstant.landingSpiralAngle,
            child: SvgPicture.asset(AssetRes.icLandingSpiral),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(NamedRoutes.home.routeName),
      child: HardShadowBox(
        color: AppColors.primaryLime,
        borderWidth: NumberConstant.landingButtonBorderWidth,
        padding: .symmetric(vertical: 19.5),
        child: Row(
          mainAxisAlignment: .center,
          spacing: NumberConstant.landingButtonContentGap,
          children: [
            Text(StringConst.signUp.toUpperCase(), style: AppTextStyles.signUpButton),
            SvgPicture.asset(AssetRes.icSignUpArrow),
          ],
        ),
      ),
    );
  }
}
