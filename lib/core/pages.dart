import 'package:get/get.dart';

import '/pages/documents_pages/document_view_page.dart';
import '/pages/reset_page/code_reset_page/code_reset_page.dart';
import '/pages/reset_page/reset_page/reset_page.dart';
import '/pages/onboarding_greeting_page/onboarding_greeting_page.dart';
import '/pages/onboarding_settings_page/onboarding_settings_page.dart';
import '/pages/auth_page/auth_page.dart';
import '/pages/loading_page.dart';
import '/pages/registration/qr_scanner_page/qr_scanner_page.dart';
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
  GetPage(name: '/home', page: () => const HomePage()),
  GetPage(name: '/settings', page: () => const SettingsPage()),
  GetPage(name: '/profile_setting', page: () => ProfileSettingPage()),
  GetPage(
      name: '/onboarding_greeting', page: () => const GreetingOnboardingPage()),
  GetPage(
      name: '/onboarding_settings', page: () => const OnboardingSettingsPage()),
  GetPage(name: '/reset', page: () => const ResetPage()),
  GetPage(name: '/reset/sms', page: () => const SMSCodePage()),
  GetPage(
      name: '/agreement',
      page: () => const DocumentViewPage(
          title: 'Пользовательское соглашение', route: '/user_agreement.docx')),
  GetPage(
      name: '/personal_data_politics',
      page: () => const DocumentViewPage(
          title: 'Политика обработки персональных данных',
          route: '/personal_data_politics.docx')),
];
