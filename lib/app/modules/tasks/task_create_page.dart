import 'package:flutter/material.dart';
import 'package:todo_list/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/core/widget/todo_list_field.dart';
import 'package:todo_list/app/modules/tasks/task_create_controller.dart';
import 'package:todo_list/app/modules/tasks/widget/calendar_button.dart';
import 'package:validatorless/validatorless.dart';

class TaskCreatePage extends StatefulWidget {
  final TaskCreateController _controller;

  TaskCreatePage({super.key, required TaskCreateController controller})
    : _controller = controller;

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final descriptionEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: widget._controller).listener(context: context, successCallback: (notifier, listenerInstance) {
      listenerInstance.dispose();
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    descriptionEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid){
            widget._controller.save(descriptionEC.text);
          }
        },
        label: Text('Salvar Task', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: context.primaryColor,
      ),
      body: Form(
        key: _formKey,
        child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text('Criar Atividade', style: context.titleStyle.copyWith(fontSize: 20),)),
            SizedBox(height: 30,),
            TodoListField(label: '', controller: descriptionEC,
            validator: Validatorless.required('Descrição obrigatória'),),
            SizedBox(height: 20,),
            CalendarButton(),
          ],
        ),
      )),
    );
  }
}
