import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          SvgPicture.asset(onboardingInfo.image),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              onboardingInfo.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
