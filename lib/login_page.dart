import 'package:breadapp/constants.dart';
import 'package:breadapp/sign_up_page.dart';
import 'package:breadapp/widgets/custom_buttom.dart';
import 'package:breadapp/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: KPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(children: [
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 240,
                child: Image.asset('images/simple bread logo.png')),
          ),
          const Text("Sign In",
              style: TextStyle(color: Colors.black, fontSize: 32),
              textAlign: TextAlign.center),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              mycontroller: email,
              hintText: "Email",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField( obscureText: true,
              mycontroller: password,
              hintText: "Password",
            ),
          ),
          CustomButtom(
            text: "Sign In",
            onTap: () async {
              try {
                final credential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email.text, password: password.text);
                Navigator.of(context).pushReplacementNamed('HomePage');
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(e
                          .toString()))); // That's it to display an alert, use other properties to customize.
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(showCloseIcon: true, content: Text(e.toString())));
              }
            },
          ),
          Row(
            children: [
              const Text(
                " Don't have an account ?  ",
                style: TextStyle(color: Colors.black87),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, "SignUp");
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(color: KSecondryColor),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
