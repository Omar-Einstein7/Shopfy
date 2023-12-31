import 'package:cached_memory_image/provider/cached_memory_image_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopfy/view/ProductViewer.dart';
import 'package:shopfy/view/widgets/theme.dart';
import 'package:shopfy/view_model/themesprovider.dart';

class CustomProduct extends StatelessWidget {
  CustomProduct(
      {super.key,
      this.i,
      required this.name,
      required this.price,
      required this.id,
      required this.img});
  final String name;
  final String price;
  final String id;
  final String img;
  int? i;

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailsView(
                      image: img,
                      id: int.parse(id),
                      name: name,
                      price: double.parse(price),
                      quantity: 1,
                      // product: product ,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            color: themeProvider.themeMode().widget,
            borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.all(5),
        width: 150,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    color: themeProvider.themeMode().widget,
                    borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Center(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      // child: Image.network(
                      //   img,
                      //   fit: BoxFit.fill,
                      //   width: 200,
                      // ),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        width: 200,
                        imageUrl: img,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: heading6.copyWith()),
                      Text(price, style: heading6.copyWith()),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
