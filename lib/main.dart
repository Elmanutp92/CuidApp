

import 'package:cuida_app/firebase_options.dart';
import 'package:cuida_app/pages/login/login.dart';
import 'package:cuida_app/provider/person_list_info.dart';
import 'package:cuida_app/provider/user_data_info.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
     MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDataInfo()),
        ChangeNotifierProvider(create: (_) => PersonListProvider()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Login(),
    );
  }
}
