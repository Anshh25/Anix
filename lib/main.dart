import 'package:anix/V/SignInScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'V/Splash.dart';
import 'firebase_options.dart';

Future<void> main() async {

  await Firebase.initializeApp(
    name: "anix",


    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
