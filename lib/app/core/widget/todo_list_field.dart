import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/todo_list_icons.dart';

class TodoListField extends StatelessWidget {
  final String label;
  final IconButton? suffixIconButton;
  final bool obscureText;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  TodoListField({
    super.key,
    required this.label,
    this.suffixIconButton,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.focusNode
  }) : assert(
         obscureText == true ? suffixIconButton == null : true,
         'obscureText não pode ser enviado em conjunto com sufixIconButton',
       ),
       obscureTextVN = ValueNotifier(obscureText);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,
      builder: (_, obscureTextValue, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(fontSize: 15, color: Colors.black),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.red),
            ),
            isDense: true,
            suffixIcon:
                suffixIconButton ??
                (obscureText
                    ? IconButton(
                        onPressed: () {
                          obscureTextVN.value = !obscureTextValue;
                        },
                        icon: !obscureTextValue
                            ? Icon(TodoListIcons.eye_closed)
                            : Icon(TodoListIcons.eye),
                      )
                    : null),
          ),
          obscureText: obscureTextValue,
        );
      },
    );
  }
}
