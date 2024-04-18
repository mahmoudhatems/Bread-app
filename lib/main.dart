import 'package:breadapp/firebase_options.dart';
import 'package:breadapp/home_page.dart';
import 'package:breadapp/login_page.dart';
import 'package:breadapp/sign_up_page.dart';
import 'package:breadapp/widgets/dependency_injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: FirebaseAuth.instance.currentUser == null ? "LoginPage" : "HomePage",
      routes: {
        "LoginPage": (context) => const LoginPage(),
        "SignUp": (context) => const SignUp(),
        "HomePage": (context) => const HomePage(),
      },
    );
  }
}
