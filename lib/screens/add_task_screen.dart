import 'package:flutter/material.dart';
import 'package:kawaii_habit_tracker/constants/color.dart';
import 'package:kawaii_habit_tracker/components/add_task_field.dart';
import '../constants/styles.dart';

class AddTaskScreen extends StatefulWidget {
  final String? initialTitle;
  final String? initialDesc;

  const AddTaskScreen({super.key, this.initialTitle, this.initialDesc});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTitle ?? '';
    _descController.text = widget.initialDesc ?? '';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveTask() {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a task title',
            style: subtitleText.copyWith(color: Colors.white),
          ),
          backgroundColor: deepPink,
        ),
      );
      return;
    }

    Navigator.pop(context, {
      'title': title,
      'desc': desc,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/background/b3.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: [
                    //  SizedBox(height: 65),
                          
                    // Image.asset('assets/cloud.png', height: 170),
                    //  SizedBox(height: 25),
                    addTaskField('Name', _titleController),
                    const SizedBox(height: 15),
                    addTaskField('Description', _descController, maxLines: 5),
                    const SizedBox(height: 40),
                    //  Spacer(),
                    GestureDetector(
                      onTap: _saveTask,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: deepPink,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(width: 4, color: softBrown),
                        ),
                        child: Text(
                          widget.initialTitle != null ? 'Update Task' : 'Add Task',
                          style: subtitleText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
