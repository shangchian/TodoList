import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../locator.dart';
import '../routes/app_router.dart';
import '../viewmodels/home_viewmodel.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  HomeView({super.key});

  final ValueNotifier<String> _searchQueryNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final model = locator<HomeViewModel>();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          model.fetchTasks();
        });
        return model;
      },
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) {
          return ValueListenableBuilder<String>(
            valueListenable: _searchQueryNotifier,
            builder: (context, _searchQuery, child) {
              final tasks = model.tasks
                  .where((task) => task.title.contains(_searchQuery))
                  .toList();

              final upcomingTasks = tasks.where((task) =>
              task.dueDate.isAfter(DateTime.now()) && !task.isCompleted).toList();

              final overdueTasks = tasks.where((task) =>
              task.dueDate.isBefore(DateTime.now()) && !task.isCompleted).toList();

              return Scaffold(
                appBar: AppBar(
                  title: Text('Todo List'),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(kToolbarHeight),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search tasks',
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        onChanged: (query) {
                          _searchQueryNotifier.value = query;
                        },
                      ),
                    ),
                  ),
                ),
                body: ListView(
                  children: [
                    if (overdueTasks.isNotEmpty) ...[
                      ListTile(
                        title: Text('Overdue Tasks', style: TextStyle(color: Colors.red)),
                      ),
                      ...overdueTasks.map((task) => ListTile(
                        title: Text(task.title),
                        subtitle: Text(task.description),
                        trailing: Checkbox(
                          value: task.isCompleted,
                          onChanged: (bool? value) {
                            model.updateTask(task.copyWith(isCompleted: value ?? false));
                          },
                        ),
                        onTap: () {
                          context.router.push(TaskDetailRoute(task: task));
                        },
                      )),
                    ],
                    if (upcomingTasks.isNotEmpty) ...[
                      ListTile(
                        title: Text('Upcoming Tasks'),
                      ),
                      ...upcomingTasks.map((task) => ListTile(
                        title: Text(task.title),
                        subtitle: Text(task.description),
                        trailing: Checkbox(
                          value: task.isCompleted,
                          onChanged: (bool? value) {
                            model.updateTask(task.copyWith(isCompleted: value ?? false));
                          },
                        ),
                        onTap: () {
                          context.router.push(TaskDetailRoute(task: task));
                        },
                      )),
                    ],
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    model.addNewTask(context);
                  },
                  child: Icon(Icons.add),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



// class _HomeViewState extends State<HomeView> {
//
// }
