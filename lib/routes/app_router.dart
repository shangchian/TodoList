import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import '../models/task.dart';
import '../views/home_view.dart';
import '../views/task_detail_view.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/',
      initial: true,
      page: HomeRoute.page,
    ),
    AutoRoute(
      path: '/task-detail',
      page: TaskDetailRoute.page,
    ),
  ];
}
