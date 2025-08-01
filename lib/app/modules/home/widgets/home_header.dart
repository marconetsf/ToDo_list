import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/auth/auth_provider.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';

class HomeHeader extends StatelessWidget {

  const HomeHeader({ super.key });

   @override
   Widget build(BuildContext context) {
       return Padding(
         padding: const EdgeInsets.symmetric(vertical: 20),
         child: Selector<AuthProvider1, String>(
           selector: (context, authProvider){
             return authProvider.user?.displayName ?? '2PAC';
           },
           builder: (_, value, __) {
             var firstName = value.split(' ')[0];
             return Text("E aí, $firstName!", style: context.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),);
           },
         ),
       );
  }
}