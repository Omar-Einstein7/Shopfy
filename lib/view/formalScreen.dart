import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopfy/view/widgets/CustomProduct.dart';
import 'package:shopfy/view_model/Firestorecart.dart';
import 'package:shopfy/view_model/themesprovider.dart';

class FormalScreen extends StatefulWidget {
  const FormalScreen({super.key});

  @override
  State<FormalScreen> createState() => _FormalScreenState();
}

class _FormalScreenState extends State<FormalScreen> {
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref().child("recomended");
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: FirebaseAnimatedList(
            // physics: BouncingScrollPhysics(),
            query: ref.orderByChild("Category").equalTo('Formal Outfits'),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, snap, anime, i) {
              int id = int.parse(snap.child("ID").value.toString());
              return Container(
                margin: EdgeInsets.all(15),
                width: 180,
                height: 200,
                decoration: BoxDecoration(
                    color: themeProvider.themeMode().widget,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Expanded(
                      child: Image.network(
                        snap.child("imageurl").value.toString(),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(snap.child("Name").value.toString())),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text("500")),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
