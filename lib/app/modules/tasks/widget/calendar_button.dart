import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/modules/tasks/task_create_controller.dart';

class CalendarButton extends StatelessWidget {
  
  final dateFormat = DateFormat('dd/MM/y');

  CalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {

        var lastDate = DateTime.now();
        lastDate = lastDate.add(Duration(days: 10 * 365));

        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: lastDate,
        );

        context.read<TaskCreateController>().selectedDate = selectedDate;

      },
      child: Container(
        //width: 200,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.today, color: Colors.grey),
            SizedBox(width: 10),
            Selector<TaskCreateController, DateTime?>(
              selector: (context, controller){
                return controller.selectedDate;
              },
              builder: (context, selectedDate, child){
                if (selectedDate != null){
                  return Text(dateFormat.format(selectedDate), style: context.titleStyle);
                } else {
                  return  Text('SELECIONE UMA DATA', style: context.titleStyle);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
