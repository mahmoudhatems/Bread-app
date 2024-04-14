import 'package:breadapp/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, this.onTap, required this.text}) : super(key: key);

  final VoidCallback? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: ElevatedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all(BorderSide(width: 0.5)),
          padding: MaterialStateProperty.all(EdgeInsets.all(screenWidth * 0.02)),
          backgroundColor: MaterialStateProperty.all(KSecondryColor),
          overlayColor: MaterialStateProperty.all(KSecondryColorlight),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
        ),
        onPressed: onTap,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: screenWidth * 0.06, // Adjust the font size based on the screen width
              color: KPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
