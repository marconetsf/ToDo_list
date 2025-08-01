import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';
import 'package:todo_list/app/models/total_tasks_model.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';

class TodoCardFilter extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTasksModel? totalTasks;
  final bool selected;

  const TodoCardFilter({
    super.key,
    required this.label,
    required this.taskFilter,
    this.totalTasks,
    required this.selected,
  });

  double _getPercentFinished() {
    if (totalTasks == null) {
      return 0.0;
    } else if (totalTasks?.totalTasks != 0){
      return ((totalTasks!.totalFinishedTasks) / (totalTasks!.totalTasks));
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<HomeController>().findTasks(filter: taskFilter),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        constraints: BoxConstraints(minHeight: 120, maxWidth: 150),
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected ? context.primaryColor : context.primaryColorLight,
          border: Border.all(
            width: 1,
            color: Colors.grey.withValues(alpha: .8),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${(totalTasks?.totalTasks ?? 0) - (totalTasks?.totalFinishedTasks ?? 0)} TASKS',
              style: context.titleStyle.copyWith(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 18),
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: _getPercentFinished()),
              duration: Duration(seconds: 1),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  backgroundColor: selected
                      ? context.primaryColorLight
                      : Colors.grey.shade300,
                  value: value,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    selected ? Colors.white : context.primaryColor,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
