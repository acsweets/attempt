import 'package:attempt/attempt.dart';
import 'package:flutter/material.dart';
import '../../widget/tree_nav.dart';

RouteBase get appRoutes => GoRoute(
      path: AppRoutes.root.name,
      redirect: (_, state) {
        if (state.fullPath == '/') {
          return AppRoutes.home.name;
        }
        return null;
      },
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
