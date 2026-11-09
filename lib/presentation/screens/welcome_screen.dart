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
    return DottedScaffoldBackground(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: Image.asset(AssetRes.landingIllustration, fit: .contain, width: double.infinity)),
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
                        _buildHeadline(),
                        _buildSignUpButton(context),
                      ],
                    ),
                    Center(child: Text(StringConst.termsOfUse, style: AppTextStyles.termsLink)),
                  ],
                ),
              ),
            ],
          ),
        ),
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
