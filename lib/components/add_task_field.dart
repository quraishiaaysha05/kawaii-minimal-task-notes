import 'package:flutter/material.dart';
import 'package:kawaii_habit_tracker/constants/styles.dart';
import '../constants/color.dart';

Widget addTaskField(
  String hintText,
  TextEditingController controller, {
  int maxLines = 1,
}) {
  return TextField(
    controller: controller,
    cursorColor: softBrown,
    maxLines: maxLines,
    minLines: 1,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: subtitleText,
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: softBrown,
          width: 3.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: softBrown,
          width: 3.5,
        ),
      ),
    ),
  );
}
