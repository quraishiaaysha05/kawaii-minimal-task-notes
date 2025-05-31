import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_model.dart';

class TaskStorage {
  static const String _tasksKey = 'tasks';

  static Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = tasks.map((t) => t.toJson()).toList();
    prefs.setString(_tasksKey, jsonEncode(taskList));
  }

  static Future<List<TaskModel>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_tasksKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.map((json) => TaskModel.fromJson(json)).toList();
  }
}
