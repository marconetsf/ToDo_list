import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';
import 'package:todo_list/app/services/tasks/tasks_service.dart';

class Task extends StatelessWidget {
  final TaskModel model;
  final dateFormat = DateFormat('dd/MM/y');

  Task({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey)],
      ),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child: Dismissible(
          key: ValueKey<int>(model.id),
          background: Container(
            decoration: BoxDecoration(
              color: Colors.red.shade300,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onDismissed:(direction) async {
            await context.read<TasksService>().deleteTaskById(model.id);
            context.read<HomeController>().refreshPage();
          },
          child: ListTile(
            contentPadding: EdgeInsets.all(8),
            leading: Checkbox(
              value: model.finished,
              onChanged: (value) =>
                  context.read<HomeController>().checkOrUncheckTask(model),
            ),
            title: Text(
              model.description,
              style: TextStyle(
                decoration: model.finished ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(
              dateFormat.format(model.dateTime),
              style: TextStyle(
                decoration: model.finished ? TextDecoration.lineThrough : null,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(20),
              side: BorderSide(width: 1, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
