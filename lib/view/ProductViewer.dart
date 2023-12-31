import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopfy/view_model/Firestorecart.dart';
import 'package:shopfy/view_model/themesprovider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProductDetailsView extends StatefulWidget {
  ProductDetailsView(
      {Key? key,
      this.image,
      this.id,
      this.name,
      this.price,
      this.quantity,
      this.iswishlist})
      : super(key: key);
  final String? image;
  final int? id;
  final int? quantity;
  final String? name;
  final double? price;
  final bool? iswishlist;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<FirestoreCart>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .35,
            padding: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            child: Image.network(
              widget.image!,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40, right: 14, left: 14),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.name.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        // Text(
                        //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor consectetur tortor vitae interdum.',
                        //   style: GoogleFonts.poppins(
                        //     fontSize: 15,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        Text(
                          "${widget.price.toString()} Dollar",
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                  ),
                ),
                child: IconButton(
                    onPressed: () async {
                      final FirebaseAuth u = FirebaseAuth.instance;
                      provider.addtowishlist(
                          widget.id.toString(),
                          widget.name.toString(),
                          widget.price!,
                          u.currentUser!.uid,
                          widget.image.toString());

                      showTopSnackBar(
                        Overlay.of(context),
                        CustomSnackBar.success(
                          message: "Add to Favourite Successfully",
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: themeProvider.themeMode().widget,
                    ))),
            SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: () async {
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.success(
                      message: "Add to Cart Successfully",
                    ),
                  );
                  final FirebaseAuth u = FirebaseAuth.instance;
                  provider.addToCart(
                      widget.id.toString(),
                      widget.name.toString(),
                      widget.price!,
                      widget.quantity!,
                      u.currentUser!.uid,
                      widget.image.toString());
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '+ Add to Cart',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
