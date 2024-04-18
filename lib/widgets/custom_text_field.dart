import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   const CustomTextField({super.key, this.hintText,this.obscureText=false, required this.mycontroller});
final String? hintText;
final bool obscureText;
final TextEditingController mycontroller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:8,left: 8),
      child: TextField(
        obscureText: obscureText,
        controller: mycontroller,
            decoration: InputDecoration(
              hintText:hintText ,
              hintStyle: const TextStyle(
                color:  Colors.black54
              ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.black)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black))),
          ),
    );
  }
}