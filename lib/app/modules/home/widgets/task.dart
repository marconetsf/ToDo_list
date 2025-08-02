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
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(30),
          child: Dismissible(
            direction: DismissDirection.endToStart,
            key: ValueKey<int>(model.id),
            background: Container(
              decoration: BoxDecoration(
                color: Colors.red.shade300,
                // borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Row(
                  children: [
                    Spacer(),
                    Icon(
                      Icons.restore_from_trash_sharp,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
            onDismissed: (direction) async {
              await context.read<TasksService>().deleteTaskById(model.id);
              context.read<HomeController>().refreshPage();
            },
            child: Container(
              height: 85,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                // border: BoxBorder.all(width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Checkbox(
                      value: model.finished,
                      onChanged: (value) => context
                          .read<HomeController>()
                          .checkOrUncheckTask(model),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        model.description,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          decoration: model.finished
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        dateFormat.format(model.dateTime),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: model.finished
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
