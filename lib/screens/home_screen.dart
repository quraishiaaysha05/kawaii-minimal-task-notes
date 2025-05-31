import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; // Add uuid to pubspec.yaml
import 'package:kawaii_habit_tracker/components/task_tile.dart';
import 'package:kawaii_habit_tracker/constants/styles.dart';
import 'package:kawaii_habit_tracker/models/task_model.dart';
import 'package:kawaii_habit_tracker/screens/add_task_screen.dart';
import 'package:kawaii_habit_tracker/screens/task_detail_screen.dart';
import 'package:kawaii_habit_tracker/constants/color.dart';

import '../service/task_storage.dart'; // Import the storage class

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final List<TaskModel> _tasks = [];
  final uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final loadedTasks = await TaskStorage.loadTasks();
    setState(() {
      _tasks.clear();
      _tasks.addAll(loadedTasks);
    });
  }

  Future<void> _saveTasks() async {
    await TaskStorage.saveTasks(_tasks);
  }

  void addTask(String title, String desc) {
    setState(() {
      _tasks.add(TaskModel(
        id: uuid.v4(),
        title: title,
        description: desc,
      ));
    });
    _saveTasks();
  }

  void _toggleDone(int index) {
    setState(() {
      final task = _tasks[index];
      _tasks[index] = TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        isDone: !task.isDone,
      );
    });
    _saveTasks();
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    _saveTasks();
  }

  double _getProgress() {
    if (_tasks.isEmpty) return 0.0;
    int completed = _tasks.where((task) => task.isDone).length;
    return completed / _tasks.length;
  }

  void _taskDetails(int index) {
    final task = _tasks[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailScreen(
          title: task.title,
          description: task.description,
          onTaskUpdated: (updatedTitle, updatedDesc) {
            setState(() {
              _tasks[index] = TaskModel(
                id: task.id,
                title: updatedTitle,
                description: updatedDesc,
                isDone: task.isDone,
              );
            });
            _saveTasks();
          },
        ),
      ),
    );
  }

  void _confirmDeleteTask(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: white,
        title: Text(
          'Delete Task?',
          style: subtitleText,
        ),
        content: Text(
          'Are you sure you want to delete this task?',
          style: bodyText,
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(deepPink),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: bodyText),
          ),
          TextButton(
             style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(deepPink),
            ),
            onPressed: () {
              Navigator.pop(context);
              _deleteTask(index);
            },
            child: Text('Delete', style: bodyText),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<TaskModel> sortedTasks = [
      ..._tasks.where((t) => !t.isDone),
      ..._tasks.where((t) => t.isDone),
    ];

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/background/b3.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Text('What’s on your list?', style: titleText),
                  SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    height: 35,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 3.5, color: softBrown),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: LinearProgressIndicator(
                            value: _getProgress(),
                            backgroundColor: Colors.transparent,
                            color: deepPink,
                            minHeight: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            _getProgress() == 0
                                ? 'Let\'s start! 🌱'
                                : '${(_getProgress() * 100).round()}% done 🎉',
                            style: bodyText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  _tasks.isEmpty
                      ? Expanded(
                          child: Center(
                            child: Text(
                              'No tasks yet. Tap + to add one!',
                              style: titleText,
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: sortedTasks.length,
                            itemBuilder: (context, index) {
                              final task = sortedTasks[index];
                              final realIndex =
                                  _tasks.indexWhere((t) => t.id == task.id);

                              return TaskTile(
                                title: task.title,
                                desc: task.description,
                                isDone: task.isDone,
                                onTap: () => _toggleDone(realIndex),
                                onDelete: () => _confirmDeleteTask(realIndex),
                                iconTap: () => _taskDetails(realIndex),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddTaskScreen()),
            );

            if (result != null && result is Map<String, String>) {
              addTask(result['title']!, result['desc'] ?? '');
            }
          },
          backgroundColor: white,
          child: Icon(Icons.add, color: softBrown),
        ),
      ),
    );
  }
}
