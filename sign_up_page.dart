import 'package:breadapp/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'widgets/custom_buttom.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(children: [
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 240,
                child: Image.asset('images/simple bread logo.png')),
          ),
          Text("Sign Up",
              style: TextStyle(color: Colors.black, fontSize: 32),
              textAlign: TextAlign.center),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              hintText: "Email",
              mycontroller: email,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              hintText: "Password",
              mycontroller: password,
            ),
          ),
          CustomButtom(
            onTap: () async {
              try {
                final credential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email.text,
                  password: password.text,
                );
                Navigator.pushReplacementNamed(context, "HomePage");
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(showCloseIcon: true, content: Text(e.toString())));
                print(e);
              }
            },
            text: "Sign Up",
          ),
          Row(
            children: [
              Text(
                " Already have an account ?  ",
                style: TextStyle(color: Colors.black87),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("LoginPage");
                },
                child: Text(
                  'Sign In ',
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
