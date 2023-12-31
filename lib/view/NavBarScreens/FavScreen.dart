import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopfy/model/product_model.dart';
import 'package:shopfy/view_model/themesprovider.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final CollectionReference<Map<String, dynamic>> wishlist =
        FirebaseFirestore.instance.collection('wishlist');
    final FirebaseAuth u = FirebaseAuth.instance;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          primary: false,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: wishlist
                        .where("userid", isEqualTo: u.currentUser!.uid)
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      List<Product> products = snapshot.data!.docs
                          .map((doc) => Product.fromFirestore(doc))
                          .toList();

                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: products.length,
                                itemBuilder: (_, i) {
                                  return Container(
                                    margin: EdgeInsets.all(5),
                                    width: 180,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        color: themeProvider.themeMode().widget,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Image.network(
                                            products[i].img.toString(),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                  FirebaseFirestore.instance
                                                      .collection('wishlist')
                                                      .doc(products[i].id)
                                                      .delete();
                                                },
                                                icon: Icon(Icons.remove)),
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child:
                                                      Text(products[i].name)),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(20),
                                              child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Text(products[i]
                                                      .price
                                                      .toString())),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      );
                    })),
          ],
        ));
  }
}
