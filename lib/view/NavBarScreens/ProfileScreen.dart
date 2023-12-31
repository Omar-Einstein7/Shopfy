import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopfy/model/user_model.dart';
import 'package:shopfy/view/widgets/theme.dart';
import 'package:shopfy/view_model/AuthFirebase.dart';
import 'package:shopfy/view_model/themesprovider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});
  // final UserModel user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<AuthFirebase>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final user = FirebaseAuth.instance.currentUser;

    String? imagurl;
    XFile? file;
    // XFile? imagefile;
    // Future pickimage() async {
    //   XFile? pickedfile =
    //       await ImagePicker().pickImage(source: ImageSource.gallery);
    //   if (pickedfile != null) {
    //     setState(() {
    //       imagefile = XFile(pickedfile.path);
    //     });
    //   }
    // }

    return FutureBuilder<UserModel?>(
        future: authprovider.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  actions: [
                    TextButton(
                        onPressed: () async {
                          // authprovider.logout();
                        },
                        child: Text("GO")),
                    Switch(
                        value: themeProvider.isLightTheme,
                        onChanged: (v) {
                          themeProvider.toggleTheme();
                        }),
                  ],
                ),
                body: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 90),
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: themeProvider.themeMode().widget,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40),
                                )),
                            height: 280,
                          ),
                          Positioned(
                            top: 280 - 144 / 2,
                            child: GestureDetector(
                              onTap: () async {
                                ImagePicker imagePicker = ImagePicker();
                                file = await imagePicker.pickImage(
                                    source: ImageSource.gallery);
                                print("${file?.path}");

                                String uniqname = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();

                                Reference referenceRoot =
                                    FirebaseStorage.instance.ref();
                                Reference referenceDirImage =
                                    referenceRoot.child("userimg");
                                Reference referenceimgtoupload =
                                    referenceDirImage.child(file!.name);

                                try {
                                  await referenceimgtoupload
                                      .putFile(File(file!.path));
                                  imagurl = await referenceimgtoupload
                                      .getDownloadURL();

                                  print(imagurl);
                                } catch (e) {}
                              },
                              child: CircleAvatar(
                                child: Text("${user?.email![0]}",
                                    style: heading6.copyWith(fontSize: 80)),
                                radius: 144 / 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "",
                      style: TextStyle(fontSize: 20),
                    ),
                    Center(
                        child: imagurl == null
                            ? Text("")
                            : Image.network(imagurl!)),
                    ListTile(
                        leading: Icon(
                          Icons.change_circle,
                          color: themeProvider.themeMode().switchcolor,
                        ),
                        title: Text(
                          'Change theme',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.themeMode().switchcolor),
                        ),
                        trailing: Switch(
                            value: themeProvider.isLightTheme,
                            onChanged: (value) => themeProvider.toggleTheme())),
                    ListTile(
                        leading: Icon(
                          Icons.change_circle,
                          color: themeProvider.themeMode().switchcolor,
                        ),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.themeMode().switchcolor),
                        ),
                        trailing: TextButton(
                          child: Text(""),
                          onPressed: () async {
                            authprovider.logout();
                          },
                        )),
                  ],
                ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
