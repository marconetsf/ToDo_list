

import 'package:flutter/material.dart';
import 'package:todo_list/app/core/database/sqlite_connection_factory.dart';

class SqliteAdmConnection with WidgetsBindingObserver{
  final connection = SqliteConnectionFactory();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){

    switch (state){
      
      case AppLifecycleState.resumed:
      break;
      
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      connection.closeConnection();
      break;
    }

  }
  
}