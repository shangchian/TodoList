import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../routes/app_router.dart';
import 'base_viewmodel.dart';
import 'global_viewmodel.dart';


class HomeViewModel extends BaseViewModel {
  final GlobalViewModel _globalViewModel;

  HomeViewModel(this._globalViewModel);

  List<Task> get tasks => _globalViewModel.tasks;

  void addNewTask(BuildContext context) {
    context.router.push(TaskDetailRoute(task: Task(
      title: '',
      description: '',
      dueDate: DateTime.now(),
      priority: 'low',
      category: '',
      id: '',
    )));
  }

  Future<void> fetchTasks() async {
    // _tasks = await globalViewModel.getTasks();
    await _globalViewModel.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _globalViewModel.addTask(task);
    await fetchTasks();
  }

  Future<void> updateTask(Task task) async {
    await _globalViewModel.updateTask(task);
    await fetchTasks();
  }

  Future<void> deleteTask(String id) async {
    await _globalViewModel.deleteTask(id);
    await fetchTasks();
  }
}
