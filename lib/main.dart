import 'package:ac_storage/operation/database_helper.dart';
import 'package:attempt/attempt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  runApp(const MyApp());
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  DatabaseHelper().init(databaseName: 'topics');
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter _router = GoRouter(
    initialLocation: '/home',
    routes: <RouteBase>[appRoutes],
    onException: (BuildContext ctx, GoRouterState state, GoRouter router) {
      String parent = state.uri.pathSegments.first;
      if (kDebugMode) {
        print("onException::${state.uri}==============");
      }
      // router.go('/$parent/404', extra: state.uri.toString());
      router.go('/404', extra: state.uri.toString());
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadePageTransitionsBuilder(),
            TargetPlatform.iOS: FadePageTransitionsBuilder(),
            TargetPlatform.windows: FadePageTransitionsBuilder(),
          },
        ),
      ),
      routerConfig: _router,
    );
  }
}
