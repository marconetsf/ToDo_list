import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class TodoListPage extends StatelessWidget {
  final List<SingleChildWidget>? _bindings;
  final WidgetBuilder _page;

  TodoListPage({
    List<SingleChildWidget>? bindings,
    required WidgetBuilder page,
    super.key,
  }) : _bindings = bindings,
       _page = page;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: (_bindings?.isNotEmpty ?? false) 
          ? _bindings! 
          : [Provider(create: (_) => Object())],
      child: Builder(builder: (context) => _page(context)),
    );
  }
}
