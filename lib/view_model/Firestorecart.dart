import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FirestoreCart extends ChangeNotifier {
  CollectionReference cart = FirebaseFirestore.instance.collection('cart');

  CollectionReference _itemsCollection =
      FirebaseFirestore.instance.collection('cart');

  void addToCart(String productID, String productName, double price,
      int quantity, String userid, String img) {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(userid + productID)
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        // Item exists in the cart, dont add it
      } else {
        // Item does not exist, add it to the cart
        FirebaseFirestore.instance
            .collection('cart')
            .doc(userid + productID)
            .set({
          'id': productID,
          'userid': userid,
          'name': productName,
          'price': price,
          'quantity': quantity,
          'image': img
        });
      }
    });
  }

  void addtowishlist(String productID, String productName, double price,
      String userid, String img) {
    FirebaseFirestore.instance
        .collection('wishlist')
        .doc(userid + productID)
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        // Item exists in the cart, dont add it
      } else {
        // Item does not exist, add it to the cart
        FirebaseFirestore.instance
            .collection('wishlist')
            .doc(userid + productID)
            .set({
          'id': productID,
          'userid': userid,
          'name': productName,
          'price': price,
          'image': img
        });
      }
    });
  }


}
