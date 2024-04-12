import 'package:breadapp/details_page.dart';
import 'package:breadapp/firebase_options.dart';
import 'package:breadapp/home_page.dart';
import 'package:breadapp/login_page.dart';
import 'package:breadapp/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async { WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "LoginPage":(context)=>LoginPage(),
       "SignUp":(context)=>SignUp(),
        "HomePage":(context)=>HomePage(),
        "DetailsPage":(context)=>DetailsPage(),
      },
      home:FirebaseAuth.instance.currentUser==null?LoginPage():  HomePage(),
    );
  }
}
