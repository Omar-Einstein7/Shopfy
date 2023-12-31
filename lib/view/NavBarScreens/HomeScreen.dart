import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopfy/view/widgets/CustomProduct.dart';
import 'package:shopfy/view/widgets/Slider.dart';
import 'package:shopfy/view/widgets/theme.dart';
import 'package:shopfy/view_model/AuthFirebase.dart';
import 'package:shopfy/view_model/themesprovider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<AuthFirebase>(context);
    // final realtime = Provider.of<RealtimeData>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final ref = FirebaseDatabase.instance.ref().child("shop");
    final refreco = FirebaseDatabase.instance.ref().child("recomended");

    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .25,
                    decoration: BoxDecoration(
                        color: themeProvider.themeMode().widget,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40))),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.width * .85,
                      child: Column(
                        children: [
                          Expanded(
                            child: HomeSlider(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 5,
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            'Man',
                            style: heading2.copyWith(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 250,
                      child: FirebaseAnimatedList(
                          physics: BouncingScrollPhysics(),
                          query: ref.orderByChild("Gender").equalTo('men'),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, snap, anime, i) {
                            int id =
                                int.parse(snap.child("ID").value.toString());
                            double price = double.parse(
                                snap.child("Price").value.toString());
                            // int id = int.parse(u.currentUser!.uid);
                            return CustomProduct(
                              id: id.toString(),
                              name: snap.child("Name").value.toString(),
                              price: price.toString(),
                              img: snap.child("imageurl").value.toString(),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            'Women',
                            style: heading2.copyWith(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 250,
                      child: FirebaseAnimatedList(
                          physics: BouncingScrollPhysics(),
                          query: ref.orderByChild("Gender").equalTo('women'),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, snap, anime, i) {
                            int id =
                                int.parse(snap.child("ID").value.toString());
                            double price = double.parse(
                                snap.child("Price").value.toString());
                            // int id = int.parse(u.currentUser!.uid);
                            if (snap != '') {
                              return CustomProduct(
                                id: id.toString(),
                                name: snap.child("Name").value.toString(),
                                price: price.toString(),
                                img: snap.child("imageurl").value.toString(),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: themeProvider.themeMode().widget,
                                ),
                              );
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            'Recomended',
                            style: heading2.copyWith(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 250,
                      child: FirebaseAnimatedList(
                          physics: BouncingScrollPhysics(),
                          query: refreco.orderByChild("Gender").equalTo('male'),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, snap, anime, i) {
                            int id =
                                int.parse(snap.child("ID").value.toString());
                            // int id = int.parse(u.currentUser!.uid);
                            return CustomProduct(
                              id: id.toString(),
                              name: snap.child("Name").value.toString(),
                              price: "555",
                              img: snap.child("imageurl").value.toString(),
                            );
                          }),
                    ),
                  ])))
        ],
      ),
    );
  }
}
