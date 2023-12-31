import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Product {
  final String userid;
  final String id;
  final String name;
  final double price;
  final String img;
  int? quantity;
  bool inwishlist;

  Product(
      {required this.userid,
      required this.id,
      required this.name,
      required this.price,
      required this.img,
      this.quantity = 1,
      this.inwishlist = false});

  factory Product.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var data = snapshot.data() as Map<String, dynamic>;
    return Product(
        id: snapshot.id,
        userid: auth.currentUser!.uid,
        name: data['name'] ?? '',
        price: (data['price'] ?? 0).toDouble(),
        quantity: data['quantity'] ?? 1,
        inwishlist: data['inWishlist'] ?? false,
        img: data['image'] ?? '');
  }
  void toggleWishlistStatus() {
    inwishlist = !inwishlist;
  }

  double getTotalPrice() {
    return price * quantity!.toDouble();
  }
}
