import 'package:get/get_navigation/src/routes/get_route.dart';

import '/pages/home_page/home_page.dart';
import '/pages/settings/new_local_password_page/new_local_password_page.dart';
import '/pages/settings/settings_page/settings_page.dart';
import '/pages/local_auth_page/local_auth_page.dart';

const initialRoute = '/local_auth';

final pages = [
  GetPage(name: '/local_auth', page: () => const LocalAuthPage()),
  GetPage(name: '/home', page: () => const HomePage()),
  GetPage(name: '/settings', page: () => const SettingsPage()),
  GetPage(
      name: '/settings/new_local_password',
      page: () => const NewLocalPasswordPage()),
];
