import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'common/navigation/router.gr.dart';

import 'di.dart' as di;

Future<void> main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Poc Mobile Loft',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: AutoRouterDelegate(_appRouter),
    );
  }
}
