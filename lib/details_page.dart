import 'dart:io';
import 'package:flutter/material.dart';

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
      body: widget.file != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 345,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Set your desired border color here
                    width: 2, // Set the border width
                  ),
                ),
                child: Image.file(widget.file!),
              ),
            )
          : Center(
              child: Text('File is null!'), // Placeholder text when file is null
            ),
    );
  }
}