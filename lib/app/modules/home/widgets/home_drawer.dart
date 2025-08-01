import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/auth/auth_provider.dart';
import 'package:todo_list/app/core/ui/messages.dart';
import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/services/user/user_service.dart';

class HomeDrawer extends StatefulWidget {

  const HomeDrawer({ super.key });

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {

  final name = ValueNotifier<String>('');

   @override
   Widget build(BuildContext context) {
       return Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: context.primaryColor.withAlpha(70),
              ),
              child: Row(
              children: [
                Selector<AuthProvider1, String>(selector: (context, authProvider) {
                  return authProvider.user?.photoURL ?? 'https://github.com/marconetsf.png';
                }, builder: (_, value, __){
                  return CircleAvatar(
                    backgroundImage: NetworkImage(value),
                    radius: 30,
                  );
                }),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<AuthProvider1, String>(builder: (_, value, __) => Text(value, style: context.subtitle2,), selector: (context, authProvider){
                      return authProvider.user?.displayName ?? 'User Name';
                    },),
                  ),
                )
              ],
            )),
            ListTile(
              title: Text('Alterar nome'),
              onTap: (){
                showDialog(context: context, builder: (_){
                  return AlertDialog(
                    title: Text('Alterar nome'),
                    content: TextField(
                      decoration: InputDecoration(
                        labelText: 'Novo Nome'
                      ),
                      onChanged: (value){
                        name.value = value;
                      },
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("Cancelar", style: TextStyle(color: Colors.red),)),
                      TextButton(onPressed: (){
                        if (name.value.isEmpty){
                          Messages.of(context).showError('Nome Obrigatório');
                        } else {
                          context.read<UserService>().updateDisplayName(name.value);
                          Navigator.of(context).pop();
                        }
                      }, child: Text("Alterar")),
                    ],
                  );
                });
              },
            ),
            ListTile(
              title: Text('Sair'),
              onTap: (){
                context.read<AuthProvider1>().logout();
              },
            ),
          ],
        ),
       );
  }
}