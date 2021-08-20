import 'package:auto_route/auto_route.dart';

import '../../features/activities/presentation/screens/activity_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: ActivityScreen, initial: true),
  ],
)
class $AppRouter {}
