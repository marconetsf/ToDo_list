import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list/app/exception/auth_exception.dart';
import 'package:todo_list/app/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
    : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'email-already-in-use') {
        throw AuthException(
          message:
              'Email já utilizado, caso não lembre a senha, tente recupera-la',
        );
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'invalid-credential') {
        throw AuthException(message: 'Login ou senha inválido');
      }
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: e.message ?? 'Erro ao resetar senha');
    } on FirebaseAuthException catch (e, s) {
      if (e.code == 'invalid-email') {
        throw AuthException(message: e.message ?? 'E-mail não encontado');
      }
    }
  }

  @override
  Future<User?> googleLogin() async {
    // final GoogleSignInAccount? _currentAccount;
    const List<String> scopes = <String>[
      'https://www.googleapis.com/auth/contacts.readonly',
    ];

    final GoogleSignIn signIn = GoogleSignIn.instance;

    await signIn.initialize(serverClientId: '566988380116-oslr2dtleisau0bsmvg7p2jj1etjaes5.apps.googleusercontent.com');

    final completer = Completer<User?>();
    late final StreamSubscription sub;

    sub = signIn.authenticationEvents.listen((GoogleSignInAuthenticationEvent event) async {
      final user = switch (event){
        GoogleSignInAuthenticationEventSignIn() => event.user,
        GoogleSignInAuthenticationEventSignOut() => null,
      };
      sub.cancel();
      // completer.complete(user);

      if (user != null){
        final GoogleSignInClientAuthorization? authorization =
        await user.authorizationClient.authorizationForScopes(scopes);


        final googleAuth = user.authentication;
        final firebaseCredential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: authorization?.accessToken
        );

        var userCredential = await _firebaseAuth.signInWithCredential(firebaseCredential);
        completer.complete(userCredential.user);


      } else {
        completer.completeError(AuthException(message: 'Erro na autenticação Google'));
      }

    },
    onError: (err, stack) {
      sub.cancel();
      completer.completeError(
        AuthException(message: 'Erro no fluxo de autenticação')
      );
    }
    );

    signIn.attemptLightweightAuthentication();
    return completer.future;
  }

  @override
  Future<void> logout() async {
    _firebaseAuth.signOut();
  }
  
  @override
  Future<void> updateDisplayName(String name) async {
    final user = _firebaseAuth.currentUser;
    if (user != null){
      await user.updateDisplayName(name);
      user.reload();
    }
  } 
}
