/*
此類用來管理全局變數，
所有全局變數都要在此設置、編寫 getter, setter
*/


import 'package:flutter/cupertino.dart';

import '../models/task.dart';
import 'package:flutter/material.dart';

class GlobalViewModel extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;


  Future<List<Task>> getTasks() async {
    // Fetch tasks from a data source, e.g., local database or remote API
    return _tasks;
  }

  Future<void> addTask(Task task) async {
    // 添加任务到任务列表
    _tasks.add(task);
    notifyListeners();
  }

  Future<void> updateTask(Task updatedTask) async {
    // 查找并更新任务
    int index = _tasks.indexWhere((t) => t.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  Future<void> deleteTask(String taskId) async {
    // 从任务列表中删除任务
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }
}
