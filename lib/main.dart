import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app/app_module.dart';
import 'package:todo_list/firebase_options.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;

Future<void> main() async {
  // Essa chamada prepara o ambiente e inicializa todos os bindings necessários
  // Normalmente essa inicialização é async mas por termos a necessidade de utilizar
  // Funcionalidades de plataforma, como firebase, é necessário. 
  WidgetsFlutterBinding.ensureInitialized();

  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth = FirebaseAuth.instanceFor(app: app);

  runApp(AppModule());
}
