import 'package:anix/V/SignInScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  // ADD THIS LINE
  WidgetsFlutterBinding.ensureInitialized();

  // Your Firebase initialization should have the 'name' parameter removed
  // unless you are specifically using multiple Firebase apps.
  // The CLI configuration usually doesn't require it.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}