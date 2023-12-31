import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopfy/model/product_model.dart';
import 'package:shopfy/view/widgets/theme.dart';

import '../../view_model/themesprovider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    // var cart = Provider.of<CartProvider>(context);
    final CollectionReference<Map<String, dynamic>> carts =
        FirebaseFirestore.instance.collection('cart');
    final FirebaseAuth u = FirebaseAuth.instance;
    // var cartdata = CloudFireStore().getCartItems();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: carts
                  .where("userid", isEqualTo: u.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                List<Product> products = snapshot.data!.docs
                    .map((doc) => Product.fromFirestore(doc))
                    .toList();
                double totalPrice = products.fold(
                  0,
                  (previousValue, element) =>
                      previousValue + element.getTotalPrice(),
                );

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: themeProvider.themeMode().widget),
                            width: double.infinity,
                            height: 180,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Image.network(products[index].img)),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        products[index].name,
                                        style: heading5.copyWith(),
                                      ),
                                      Text(
                                        '\$${(products[index].price * products[index].quantity!).toString()}',
                                        style: heading5.copyWith(),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.remove),
                                            onPressed: () {
                                              int newQuantity =
                                                  products[index].quantity! - 1;
                                              if (newQuantity > 0) {
                                                FirebaseFirestore.instance
                                                    .collection('cart')
                                                    .doc(products[index].id)
                                                    .update({
                                                  'quantity': newQuantity
                                                });
                                              } else {
                                                FirebaseFirestore.instance
                                                    .collection('cart')
                                                    .doc(products[index].id)
                                                    .delete();
                                              }
                                            },
                                          ),
                                          Text(products[index]
                                              .quantity
                                              .toString()),
                                          IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              int newQuantity =
                                                  products[index].quantity! + 1;
                                              FirebaseFirestore.instance
                                                  .collection('cart')
                                                  .doc(products[index].id)
                                                  .update({
                                                'quantity': newQuantity
                                              });
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: Text(
      //       'Total Price: \$${totalPrice.toStringAsFixed(2)}',
      //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //     ),
      //   ),
      // ),
    );
  }
}
