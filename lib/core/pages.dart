import 'package:doctor/pages/home_page/home_page.dart';
import 'package:doctor/pages/settings_page/settings_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/local_auth_page/local_auth_page.dart';

const initialRoute = '/local_auth';

final pages = [
  GetPage(name: '/local_auth', page: () => const LocalAuthPage()),
  GetPage(name: '/home', page: () => const HomePage()),
  GetPage(name: '/settings', page: () => const SettingsPage()),
];
