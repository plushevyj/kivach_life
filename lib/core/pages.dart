import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/local_auth_page/local_auth_page.dart';

const initialRoute = '/local_auth';

final pages = <GetPage>[
  GetPage(name: '/local_auth', page: () => const LocalAuthPage()),
];
