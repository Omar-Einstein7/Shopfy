import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shopfy/model/user_model.dart';
import 'package:shopfy/view/NavBarScreens/CartScreen.dart';
import 'package:shopfy/view/NavBarScreens/FavScreen.dart';
import 'package:shopfy/view/NavBarScreens/HomeScreen.dart';
import 'package:shopfy/view/NavBarScreens/ProfileScreen.dart';
import 'package:shopfy/view/NavBarScreens/StyleScreen.dart';

class Nav_Bar extends StatefulWidget {
  Nav_Bar({super.key});
  // final UserModel user;

  @override
  State<Nav_Bar> createState() => _Nav_BarState();
}

class _Nav_BarState extends State<Nav_Bar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomeScreen(),
      StyleScreen(),
      CartScreen(),
      FavScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      primary: false,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: Colors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
          child: GNav(
            backgroundColor: Colors.transparent,
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 5,
            activeColor: Colors.black,
            iconSize: 21,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: Colors.black,
            tabs: [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: LineIcons.star,
                text: 'Styles ',
              ),
              GButton(
                icon: LineIcons.shoppingBag,
                text: 'Cart',
              ),
              GButton(
                icon: LineIcons.heart,
                text: 'Like',
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
