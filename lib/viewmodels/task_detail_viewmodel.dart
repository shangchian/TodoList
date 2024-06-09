import 'package:flutter/material.dart';
import '../models/task.dart';
import 'base_viewmodel.dart';

class TaskDetailViewModel extends BaseViewModel {
  List<Task> _tasks = [];

  Future<void> fetchTasks() async {
    _tasks = await globalViewModel.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await globalViewModel.addTask(task);
    await fetchTasks();
  }

  Future<void> updateTask(Task task) async {
    await globalViewModel.updateTask(task);
    await fetchTasks();
  }

  Future<void> deleteTask(String id, BuildContext context) async {
    await globalViewModel.deleteTask(id);
    await fetchTasks();
    Navigator.of(context).pop();
  }
}
