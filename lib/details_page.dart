import 'dart:io';
import 'package:breadapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DetailsPage extends StatefulWidget {
  final File? file; // Assuming file is a File object
  const DetailsPage({Key? key, this.file}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KPrimaryColor,
      body: Center(
        child: Lottie.asset('animations/success.json', animate: true),
      ),
    );
  }
}
