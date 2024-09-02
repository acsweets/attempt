import 'package:attempt/attempt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widget/tree_nav.dart';
import '../transition/page_route/zero_page_route.dart';

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

RouteBase get appRoutes => GoRoute(
      path: AppRoutes.root.name,
      redirect: _widgetHome,
      routes: [
        ShellRoute(
            builder: (BuildContext context, GoRouterState state, Widget child) {
              return TreeNav(
                child: child,
              );
            },
            routes: [
              GoRoute(
                path: AppRoutes.home.name,
                builder: (BuildContext context, GoRouterState state) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text('主页'),
                    ),
                  );
                },
              ),
              GoRoute(
                path: AppRoutes.animation.name,
                builder: (BuildContext context, GoRouterState state) {
                  return Scaffold(
                    body: Center(
                      child: Container(
                        child: Text("动画页"),
                      ),
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: AppRoutes.example.name,
                    builder: (BuildContext context, GoRouterState state) {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text('例子总页'),
                        ),
                      );
                    },
                    // redirect: (_, state) {
                    //   //todo 重定向后为什么会导致不把之前的选中,设置了但是没刷新
                    //   if (state.fullPath == '/animation/example') {
                    //     return '/animation/example/one';
                    //   }
                    //   return null;
                    // },
                    routes: [
                      GoRoute(
                        path: AppRoutes.one.name,
                        builder: (BuildContext context, GoRouterState state) {
                          return Scaffold(
                            appBar: AppBar(
                              title: Text('例子页面1'),
                            ),
                          );
                        },
                      ),
                      GoRoute(
                        path: AppRoutes.two.name,
                        builder: (BuildContext context, GoRouterState state) {
                          return Scaffold(
                            appBar: AppBar(
                              title: Text('例子页面2'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              GoRoute(
                path: AppRoutes.draw.name,
                builder: (BuildContext context, GoRouterState state) {
                  return Scaffold(
                    body: Center(
                      child: Container(
                        child: Text("绘制页"),
                      ),
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: AppRoutes.example.name,
                    builder: (BuildContext context, GoRouterState state) {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text('例子页面'),
                        ),
                      );
                    },
                  ),
                ],
              ),
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
            ]),
        // deskNavRoute
      ],
    );
