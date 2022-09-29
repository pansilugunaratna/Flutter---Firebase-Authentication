import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<UserCredential> signInWithGoogle() async {
  // Create a new provider
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
  googleProvider.setCustomParameters({'login_hint': 'your_email@gmail.com'});

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithPopup(googleProvider);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Authentication());
}

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final db = FirebaseFirestore.instance;

  final myController = TextEditingController();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  String response = 'Submitted successfully!';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Firebase",
      home: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                        hintText: "Enter your email here",
                        contentPadding: EdgeInsets.only(
                            top: 10.0, left: 20.0, bottom: 10.0, right: 20.0),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)))),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _password,
                    decoration: const InputDecoration(
                        hintText: "Enter your password here",
                        contentPadding: EdgeInsets.only(
                            top: 10.0, left: 20.0, bottom: 10.0, right: 20.0),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)))),
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: signin,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // background
                    onPrimary: Colors.white, // foreground
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.only(
                        top: 15.0, bottom: 15.0, left: 40.0, right: 40.0),
                  ),
                  child: const Text('Sign in'),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: signup,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // background
                    onPrimary: Colors.white, // foreground
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.only(
                        top: 15.0, bottom: 15.0, left: 40.0, right: 40.0),
                  ),
                  child: const Text('Sign up'),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: signInWithGoogle,
              style: ElevatedButton.styleFrom(
                primary: Colors.black, // background
                onPrimary: Colors.white, // foreground
                shape: const StadiumBorder(),
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 15.0, left: 40.0, right: 40.0),
              ),
              child: const Text('Sign in with Google'),
            ),
          ],
        )),
      ),
    );
  }

  signin() async {
    print("signin");
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  signup() async {
    print("signup");
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}

//Resource: https://firebase.google.com/docs/auth/flutter/start?authuser=0
