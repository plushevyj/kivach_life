import 'package:get/get.dart';

import '/pages/onboarding_greeting_page/onboarding_greeting_page.dart';
import '/pages/onboarding_settings_page/onboarding_settings_page.dart';
import '/pages/auth_page/auth_page.dart';
import '../pages/loading_page.dart';
import '/pages/registration/qr_scanner_page/qr_scanner_page.dart';
import '/pages/registration/registration_page/registration_page.dart';
import '/pages/home_page/home_page.dart';
import '/pages/settings/settings_page/settings_page.dart';
import '/pages/local_auth_page/local_auth_page.dart';
import '/pages/settings/profile_setting_page/profile_setting_page.dart';

const initialRoute = '/auth';

final pages = [
  GetPage(name: '/loading', page: () => const LoadingPage()),
  GetPage(name: '/auth', page: () => const AuthorizationPage()),
  GetPage(name: '/registration/qr', page: () => const QRScannerPage()),
  GetPage(name: '/local_auth', page: () => const LocalAuthPage()),
  GetPage(name: '/home', page: () => HomePage()),
  GetPage(name: '/settings', page: () => const SettingsPage()),
  GetPage(name: '/profile_setting', page: () => const ProfileSettingPage()),
  GetPage(
      name: '/onboarding_greeting', page: () => const GreetingOnboardingPage()),
  GetPage(
      name: '/onboarding_settings', page: () => const OnboardingSettingsPage()),
];
