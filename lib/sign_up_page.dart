
import 'package:breadapp/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'widgets/custom_buttom.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

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
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                height: 240,
                child: Image.asset('images/icon.png')),
          ),
          const Text("Sign Up",
              style: TextStyle(color: Colors.black, fontSize: 32),
              textAlign: TextAlign.center),
          const SizedBox(
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
            child: CustomTextField( obscureText: true,
              hintText: "Password",
              mycontroller: password,
            ),
          ),
          CustomButton(
            onTap: () async {
               showDialog(context: context, 
                builder: (context){
                  return const Center(child: CircularProgressIndicator(),);
                }
                
                );
              try {
                final credential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email.text.trim(),
                  password: password.text.trim(),
                );Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, "HomePage");
              } on FirebaseAuthException catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(showCloseIcon: true, content: Text(e.toString())));
                if (e.code == 'weak-password') {
                  const Text('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  const Text('The account already exists for that email.');
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(showCloseIcon: true, content: Text(e.toString())));
               // print(e);
              }
            },
            text: "Sign Up",
          ),
          Row(
            children: [
              const Text(
                " Already have an account ?  ",
                style: TextStyle(color: Colors.black87),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("LoginPage");
                },
                child: const Text(
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
