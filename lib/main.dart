//Google Authentication using Firebase

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/landingpage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final db = FirebaseFirestore.instance;

  final myController = TextEditingController();

  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Flutter Firebase Demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Authentication'),
          backgroundColor: Colors.black87,
        ),
        body: const LandingPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
