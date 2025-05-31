import 'package:flutter/material.dart';
import 'package:kawaii_habit_tracker/constants/color.dart';
import 'package:kawaii_habit_tracker/constants/styles.dart';
import 'package:kawaii_habit_tracker/screens/add_task_screen.dart';

class TaskDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final void Function(String, String) onTaskUpdated;

  const TaskDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.onTaskUpdated,
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    description = widget.description;
  }

  void _navigateToEdit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddTaskScreen(
          initialTitle: title,
          initialDesc: description,
        ),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        title = result['title']!;
        description = result['desc']!;
      });

      widget.onTaskUpdated(title, description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset('assets/background/b3.jpg', fit: BoxFit.cover),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(15),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back,
                                    size: 35, color: softBrown),
                                onPressed: () => Navigator.pop(context),
                              ),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  title,
                                  style: titleText,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(width: 40), // For symmetry
                            ],
                          ),
                          const SizedBox(height: 8),
                          Divider(color: softBrown, thickness: 3),
                          const SizedBox(height: 20),
                          Text(
                            'Description:',
                            style: bodyText,
                          ),
                          const SizedBox(height: 10),
                          SelectableText(
                            description.isNotEmpty
                                ? description
                                : 'No description provided.',
                            style: bodyText,
                          ),
                          SizedBox(height: 90),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: GestureDetector(
                  onTap: _navigateToEdit,
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 25),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 65),
                    // width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: deepPink,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(width: 4, color: softBrown),
                    ),
                    child: Text('Edit Task', style: subtitleText),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
