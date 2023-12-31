import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopfy/model/user_model.dart';
import 'package:shopfy/view/NavBarScreens/Body.dart';
import 'package:shopfy/view/auth/LoginScreen.dart';

class AuthFirebase extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserModel?> getCurrentUser() async {
    User? user = auth.currentUser;

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData =
          await firestore.collection('users').doc(user.uid).get();
      if (userData.exists) {
        // Retrieve data from Firestore document
        Map<String, dynamic> data = userData.data()!;
        UserModel userDetails = UserModel(
          id: user.uid,
          name: data["name"] ?? 'No Name',
          email: user.email ?? 'No Email',
          age: data['age'] ?? 0, // Replace 'age' with your field name in Firestore
          weight: data['weight'] ?? 0.0,
          img: '',
          gender: data['gender'], // Replace 'weight' with your field name in Firestore
        );
        return userDetails;
      }
      return null;
    }

    return null; // If no user is logged in
  }

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("complete your data")),
        );
      } else if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${e.message}")),
        );
      } else if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${e.message}")),
        );
      } else if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("pass or email is empty ")),
        );
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${e.message}")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${e.code}")),
        );
      }
    }
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String name,
      required String weight,
      required String age,
      required String gender,
      required BuildContext context}) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel newUser = UserModel(
          id: auth.currentUser!.uid,
          name: name,
          email: email,
          weight: double.tryParse(weight.toString()) ?? 0.0,
          age: int.tryParse(age.toString()) ?? 0,
          img: "",
          gender: gender);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(newUser.id)
          .set(newUser.toSnapshot());

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Nav_Bar(
                  // user: UserModel(
                  //     id: userCredential.user!.uid,
                  //     name: name,
                  //     email: email,
                  //     img: "",
                  //     age: int.tryParse(age.toString()) ?? 0,
                  //     weight: double.tryParse(weight.toString()) ?? 0),

                  )));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (email.toString().isEmpty || password.toString().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("complete your data")),
        );
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${e.message}")),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${e.message}")),
        );
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${e.message}")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${e.code}")),
        );
      }
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
