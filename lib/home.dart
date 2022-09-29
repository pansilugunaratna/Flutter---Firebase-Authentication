import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: [
        const SizedBox(height: 30),
        const Text("This is the home page"),
        const SizedBox(height: 30),
        ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.black, // background
              onPrimary: Colors.white, // foreground
              shape: const StadiumBorder(),
              padding: const EdgeInsets.only(
                  top: 15.0, bottom: 15.0, left: 40.0, right: 40.0),
            ),
            child: const Text("Sign out"))
      ]),
    ));
  }
}
