import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopfy/model/user_model.dart';
import 'package:shopfy/view/NavBarScreens/Body.dart';
import 'package:shopfy/view/auth/LoginScreen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (_, snap) {

            if (snap.hasData) {
              return Nav_Bar();
            } else {
              return LoginScreen();
            }
          }),
    );
  }
}
