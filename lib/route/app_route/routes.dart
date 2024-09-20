import 'package:attempt/attempt.dart';
import 'package:flutter/material.dart';
import '../../animation/draggable/draggable_gridview.dart';
import '../../animation/pages/turnable_page.dart';
import '../../animation/pages/two_turnable.dart';
import '../../draw/beizier/beizier_page.dart';
import '../../draw/beizier/three.dart';
import '../../draw/matrix/matrix_color.dart';
import '../../draw/rule/draw_rule.dart';
import '../../pages/tools/dropregon.dart';
import '../../pages/tools/random_name_page.dart';
import '../../widget/tree_nav.dart';

RouteBase get appRoutes =>
    GoRoute(
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
                    // builder: (BuildContext context, GoRouterState state) {
                    //   return Scaffold(
                    //     appBar: AppBar(
                    //       title: Text('例子总页'),
                    //     ),
                    //   );
                    // },
                    redirect: (_, state) {
                      //todo 重定向后为什么会导致不把之前的选中,设置了但是没刷新 ,因为我的刷新没起作用
                      if (state.fullPath == '/animation/example') {
                        return '/animation/example/one';
                      }
                      return null;
                    },
                    routes: [
                      GoRoute(
                        path: AppRoutes.one.name,
                        builder: (BuildContext context, GoRouterState state) {
                          return const TurntablePage();
                        },
                      ),
                      GoRoute(
                        path: AppRoutes.two.name,
                        builder: (BuildContext context, GoRouterState state) {
                          return SpinningPage();
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
                      return FlowingDraggableGrid();
                    },
                    routes: [
                      GoRoute(
                        path: AppRoutes.one.name,
                        builder: (BuildContext context, GoRouterState state) {
                          return BallDrawingCurveAnimation();
                        },
                      ),
                      GoRoute(
                        path: AppRoutes.two.name,
                        builder: (BuildContext context, GoRouterState state) {
                          return SpinningPage();
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: AppRoutes.cartesian.name,
                    builder: (BuildContext context, GoRouterState state) {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text('笛卡尔坐标系'),
                        ),
                        body: Center(
                          child: Column(
                            children: [
                              // SizedBox(
                              //   width: 400,
                              //   height: 400,
                              //   child: CustomPaint(
                              //     painter: CartesianPainter(),
                              //   ),
                              // ),
                              ColorFiltered(
                                colorFilter: ColorFilter.matrix([
                                  2, 0, 0, 0, 0, // 增强红色通道
                                  0, 1.2, 0, 0, 0, // 增强绿色通道
                                  0, 0, 0.5, 0, 0, // 增强蓝色通道
                                  0, 0, 0, 1, 0,   // Alpha通道保持不变
                                ]),
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  color: Colors.lightGreenAccent, // 初始颜色
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: AppRoutes.tools.name,
                builder: (BuildContext context, GoRouterState state) {
                  return Scaffold(
                    body: Center(
                      child: Container(
                        child: Text("小工具"),
                      ),
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: AppRoutes.randomName.name,
                    builder: (BuildContext context, GoRouterState state) {
                      return const RandomNamePage();
                    },
                  ),
                  GoRoute(
                    path: AppRoutes.saber.name,
                    builder: (BuildContext context, GoRouterState state) {
                      return const SaberPage();
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
