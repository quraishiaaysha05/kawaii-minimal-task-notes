import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kawaii_habit_tracker/constants/color.dart';
import '../constants/styles.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final String desc;
  final bool isDone;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback iconTap;

  const TaskTile({
    super.key,
    required this.title,
    required this.desc,
    required this.isDone,
    required this.onTap,
    required this.onDelete,
    required this.iconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 4.5, color: softBrown),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => onDelete(),
                backgroundColor: deepPink,
                icon: Icons.delete,
                foregroundColor: softBrown,
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            leading: GestureDetector(
              onTap: onTap,
              child: Icon(
                isDone
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked_rounded,
                color: softBrown,
                size: 28,
              ),
            ),
            title: Text(
              title,
              style: subtitleText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            subtitle: desc.isNotEmpty
                ? Text(
                    desc,
                    style: bodyText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                : null,
            trailing: IconButton(
              onPressed: iconTap,
              icon: const Icon(Icons.arrow_forward_ios),
              color: softBrown,
            ),
          ),
        ),
      ),
    );
  }
}
