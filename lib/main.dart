import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfy/firebase_options.dart';
import 'package:shopfy/theme/util.dart';
import 'package:shopfy/view/auth/LoginScreen.dart';
import 'package:shopfy/view/auth/RegisterScreen.dart';
import 'package:shopfy/view/formalScreen.dart';
import 'package:shopfy/view/smartScreen.dart';
import 'package:shopfy/view/sportyScreen.dart';
import 'package:shopfy/view/uniScreen.dart';
import 'package:shopfy/view_model/AuthFirebase.dart';
import 'package:shopfy/view_model/Firestorecart.dart';
import 'package:shopfy/view_model/themesprovider.dart';
import 'package:shopfy/wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLightTheme = prefs.getBool(Spref.isLight) ?? true;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthFirebase()),
      ChangeNotifierProvider(create: (context) => FirestoreCart()),
      // ChangeNotifierProvider(create: (context) => CartProvider()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
      return MaterialApp(
        theme: themeProvider.themeData(),
        // darkTheme: themeProvider.themeData(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/Wrapper',
        routes: {
          '/Wrapper': (context) => Wrapper(),
          'Formal': (context) => FormalScreen(),
          'Uni': (context) => UniScreen(),
          'Sporty': (context) => SportyScreen(),
          'Smart': (context) => SmartScreen(),
          'Login': (context) => LoginScreen(),
          'Register': (context) => RegisterScreen(),
          

        },
      );
    });
  }
}
