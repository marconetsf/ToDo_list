import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app/core/navigator/todo_list_navigator.dart';
import 'package:todo_list/app/services/user/user_service.dart';

class AuthProvider1 extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final UserService _userService;

  AuthProvider1({
    required FirebaseAuth firebaseAuth,
    required UserService userService,
  }) : _firebaseAuth = firebaseAuth,
       _userService = userService;


  Future<void> logout() => _userService.logout();
  User? get user => _firebaseAuth.currentUser;

  void loadListener() {
    _firebaseAuth.userChanges().listen((_) => notifyListeners());
    _firebaseAuth.authStateChanges().listen((user) {
      if (user != null){ // login
        TodoListNavigator.to.pushNamedAndRemoveUntil('/home', (route)=> false);
      }else { // logout
        TodoListNavigator.to.pushNamedAndRemoveUntil('/login', (route)=> false);
      }
    });
  }
}
