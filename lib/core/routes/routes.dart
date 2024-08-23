import 'package:attempt/core/routes/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../page/home/detail.dart';
import '../widget/app_navigation.dart';

RouteBase get routes => GoRoute(
      path: AppRoutes.root.name,
      redirect: _widgetHome,
      routes: [
        ShellRoute(
            builder: (BuildContext context, GoRouterState state, Widget child) {
              return AppNavigation(
                child: child,
              );
            },
            routes: [
              // GoRoute(
              //   path: RoutesPath.home,
              //   builder: (BuildContext context, GoRouterState state) {
              //     return  Scaffold(
              //       appBar: AppBar(title: Text("111"),),
              //     );
              //   },
              // ),
              // GoRoute(
              //   path: 'guide',
              //   builder: (BuildContext context, GoRouterState state) {
              //     return GuideNavigation();
              //   },
              // ),
              ShellRoute(
                  builder: (BuildContext context, GoRouterState state,
                      Widget child) {
                    return Row(
                      children: [
                        Column(
                          children: [
                            TextButton(
                                onPressed: () {
                                  context.go("/two");
                                },
                                child: Text("two ")),
                            TextButton(
                                onPressed: () {
                                  context.go("/sth");
                                },
                                child: Text("sth")),
                          ],
                        ),
                        Expanded(child: child),
                      ],
                    );
                  },
                  routes: [
                    GoRoute(
                      path: AppRoutes.home.name,
                      builder: (BuildContext context, GoRouterState state) {
                        // return HomePage();
                      return SelectableItemsScreen();
                      },

                    ),
                    GoRoute(
                      path: "two",
                      builder: (BuildContext context, GoRouterState state) {
                        return Scaffold(
                          appBar: AppBar(
                            title: Text("二一级路由"),
                          ),
                        );
                      },
                    ),
                    GoRoute(
                      path: "sth",
                      builder: (BuildContext context, GoRouterState state) {
                        return Scaffold(
                          appBar: AppBar(
                            title: Text("二二级路由"),
                          ),
                        );
                      },
                    ),
                  ]),
              // GoRoute(
              //   path: RoutesPath.second,
              //   // builder: (BuildContext context, GoRouterState state) {
              //   //   return const SecondPage();
              //   // },
              //   pageBuilder: (context, state) {
              //     // final id = state.params['id'];
              //     return CustomTransitionPage(
              //       key: state.pageKey,
              //       child: SecondPage(),
              //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
              //         // 根据 ID 选择不同的动画
              //         // if (int.parse(id!) % 2 == 0) {
              //           return FadeTransition(opacity: animation, child: child);
              //         // } else {
              //         //   return SlideTransition(
              //         //     position: Tween(begin: Offset(0, 1), end: Offset.zero)
              //         //         .animate(animation),
              //         //     child: child,
              //         //   );
              //         // }
              //       },
              //     );
              //   },
              //
              //
              // ),

            ]),
        // GoRoute(
        //   path: 'splash',
        //   builder: (BuildContext context, GoRouterState state) {
        //     return const AppStartListener<AppState>(
        //       child: SplashPage(),
        //     );
        //   },
        // ),
        GoRoute(
          path: AppRoutes.error.name,
          builder: (BuildContext context, GoRouterState state) {
            return Scaffold(
              body: Center(
                child: Container(
                  child: Text("404"),
                ),
              ),
            );
          },
        ),
        // deskNavRoute
      ],
    );

String? _widgetHome(_, state) {
  if (state.fullPath == '/') {
    return AppRoutes.home.name;
  }
  return null;
}
