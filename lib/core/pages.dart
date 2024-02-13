import 'package:get/get.dart';

import '../pages/qr_scanner_page/qr_scanner_page.dart';
import '/pages/reset_password/reset_password_by_email_page/reset_password_by_email_page.dart';
import '/pages/reset_password/reset_password_by_sms_page/reset_password_by_sms_password_page.dart';
import '/pages/settings_pages/settings_page/settings_page.dart';
import '/pages/onboarding_greeting_page/onboarding_greeting_page.dart';
import '/pages/onboarding_settings_page/onboarding_settings_page.dart';
import '/pages/auth_page/auth_page.dart';
import '/pages/loading_page.dart';
import '/pages/home_page/home_page.dart';
import '/pages/local_auth_page/local_auth_page.dart';

const initialRoute = '/auth';

final pages = [
  GetPage(name: '/loading', page: () => const LoadingPage()),
  GetPage(name: '/auth', page: () => const AuthorizationPage()),
  GetPage(name: '/qr', page: () => const QRScannerPage()),
  GetPage(name: '/local_auth', page: () => const LocalAuthPage()),
  GetPage(name: '/home', page: () => const HomePage()),
  GetPage(name: '/settings', page: () => const SettingsPage()),
  GetPage(
      name: '/onboarding_greeting', page: () => const GreetingOnboardingPage()),
  GetPage(
      name: '/onboarding_settings', page: () => const OnboardingSettingsPage()),
  GetPage(name: '/reset/sms', page: () => const ResetPage()),
  GetPage(name: '/reset/email', page: () => const ResetPasswordByEmailPage()),
];
