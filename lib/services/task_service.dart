import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskService {
  final Box<Task> _taskBox;

  TaskService(this._taskBox);

  Future<List<Task>> getTasks() async {
    return _taskBox.values.toList();
  }

  Future<void> addTask(Task task) async {
    await _taskBox.put(task.id, task);
  }

  Future<void> updateTask(Task task) async {
    await _taskBox.put(task.id, task);
  }

  Future<void> deleteTask(String id) async {
    await _taskBox.delete(id);
  }
}
