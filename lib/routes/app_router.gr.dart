// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomeView(),
      );
    },
    TaskDetailRoute.name: (routeData) {
      final args = routeData.argsAs<TaskDetailRouteArgs>(
          orElse: () => const TaskDetailRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TaskDetailView(
          key: args.key,
          task: args.task,
        ),
      );
    },
  };
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TaskDetailView]
class TaskDetailRoute extends PageRouteInfo<TaskDetailRouteArgs> {
  TaskDetailRoute({
    Key? key,
    Task? task,
    List<PageRouteInfo>? children,
  }) : super(
          TaskDetailRoute.name,
          args: TaskDetailRouteArgs(
            key: key,
            task: task,
          ),
          initialChildren: children,
        );

  static const String name = 'TaskDetailRoute';

  static const PageInfo<TaskDetailRouteArgs> page =
      PageInfo<TaskDetailRouteArgs>(name);
}

class TaskDetailRouteArgs {
  const TaskDetailRouteArgs({
    this.key,
    this.task,
  });

  final Key? key;

  final Task? task;

  @override
  String toString() {
    return 'TaskDetailRouteArgs{key: $key, task: $task}';
  }
}
