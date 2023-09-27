import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core/themes/light_theme.dart';
import '/models/onboarding_info/onboarding_info.dart';

class OnboardingInfoWidget extends StatelessWidget {
  const OnboardingInfoWidget({
    super.key,
    required this.onboardingInfo,
  });

  final OnboardingInfo onboardingInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            onboardingInfo.image,
            height: isSmallScreen ? 300 : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              onboardingInfo.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
