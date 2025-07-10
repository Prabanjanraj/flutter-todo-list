import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todooo/models/task.dart';

class TaskProvider extends ChangeNotifier {
  final Box<Task> _taskBox = Hive.box<Task>('taskBox');
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  // Load tasks when provider initializes
  TaskProvider() {
    _loadTasks();
  }

  void _loadTasks() {
    _tasks = _taskBox.values.toList();
    notifyListeners();
  }

  // Add task and save to Hive
  void addTask(Task task) {
    _taskBox.add(task);
    _loadTasks(); // Reload tasks to show on HomeScreen
  }

  void deleteTask(int index) {
    _taskBox.deleteAt(index);
    _loadTasks();
  }

  void markTaskCompleted(int index) {
    _tasks[index].isCompleted = true;
    _taskBox.putAt(index, _tasks[index]);
    _loadTasks();
  }
}
