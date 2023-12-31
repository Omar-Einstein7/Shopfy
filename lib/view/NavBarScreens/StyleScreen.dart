import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopfy/view/formalScreen.dart';
import 'package:shopfy/view/widgets/CustomProduct.dart';
import 'package:shopfy/view/widgets/theme.dart';
import 'package:shopfy/view_model/AuthFirebase.dart';
import 'package:shopfy/view_model/themesprovider.dart';

class StyleScreen extends StatelessWidget {
  const StyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    List<String> styles = ["Formal", "Smart", "Sporty", "Uni"];
    final ref = FirebaseDatabase.instance.ref().child("recomended");
    final authprovider = Provider.of<AuthFirebase>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemCount: styles.length,
                  itemBuilder: (_, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "${styles[i]}");
                        print("${styles[i]}");
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: themeProvider.themeMode().widget,
                            borderRadius: BorderRadius.circular(25)),
                        // color of grid items
                        child: Center(
                          child: Text(
                            styles[i],
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Text(
                    'For You',
                    style: heading2.copyWith(),
                  ),
                ],
              ),
            ),
            Container(
              height: 250,
              child: FirebaseAnimatedList(
                  physics: BouncingScrollPhysics(),
                  query: ref.orderByChild("Gender").equalTo('male'),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, snap, anime, i) {
                    int id = int.parse(snap.child("ID").value.toString());
                    // int id = int.parse(u.currentUser!.uid);
                    return CustomProduct(
                      id: id.toString(),
                      name: snap.child("Name").value.toString(),
                      price: "555",
                      img: snap.child("imageurl").value.toString(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
