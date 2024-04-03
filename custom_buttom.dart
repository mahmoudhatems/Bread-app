import 'package:breadapp/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButtom extends StatelessWidget {
  CustomButtom({this.onTap, required this.text, super.key});
  String text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 8, bottom: 8),
      child: ElevatedButton(
        style: ButtonStyle(
          side: const MaterialStatePropertyAll(BorderSide(width: 0.5)),
          fixedSize: const MaterialStatePropertyAll(Size.fromHeight(60)),
          backgroundColor: const MaterialStatePropertyAll(KSecondryColor),
          overlayColor: const MaterialStatePropertyAll(KSecondryColorlight),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          )),
        ),
        onPressed: onTap,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 26,
              color: KPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
