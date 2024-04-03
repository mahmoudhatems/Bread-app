import 'dart:io';

import 'package:breadapp/constants.dart';
import 'package:breadapp/widgets/custom_buttom.dart';
import 'package:breadapp/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? file;
  getImage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
//final XFile? imageGallery = await picker.pickImage(source: ImageSource.gallery);
// Capture a photo.
    final XFile? imageCamera =
        await picker.pickImage(source: ImageSource.camera);
    if (imageCamera != null) {
      file = File(imageCamera.path);
    }
    setState(() {});
  }

  String? selectedbreadsize;
  int? selectedbreadweight;
  GlobalKey<FormState> formstate = GlobalKey();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KPrimaryColor,
      appBar: AppBar(backgroundColor: KPrimaryColor, actions: [
        IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("LoginPage", (route) => false);
            },
            icon: Icon(Icons.exit_to_app_outlined))
      ]),
      body: SingleChildScrollView(
        child: Form(
          key: formstate,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: KSecondryColor,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        highlightColor: KPrimaryColorDark,
                        padding: EdgeInsets.all(32),
                        onPressed: () async {
                          await getImage();
                        },
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          size: 80,
                          color: KSecondryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (file != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 345,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: KSecondryColor,
                        width: 2,
                      ),
                    ),
                    child: Image.file(file!),
                  ),
                ),

              if (file != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: KPrimaryColor,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.all(20),
                        child: DropdownButton(underline: Divider(thickness: 1,color: KSecondryColor,),
                          iconEnabledColor: KSecondryColor,
                          iconSize: 30,
                          hint: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(height:90,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom:0),
                                child: Text(
                                  "Choose Size",
                                  style: TextStyle(
                                    color: KSecondryColor,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          style: TextStyle(color: KSecondryColor),
                          dropdownColor: KPrimaryColor,
                          borderRadius: BorderRadius.circular(16),
                          items: ["Small", "Medium", "Large"]
                              .map((e) => DropdownMenuItem(
                                    child: Text(
                                      "$e",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedbreadsize = val;
                            });
                          },
                          value: selectedbreadsize,
                        ),
                      ),
                    ),
                  ],
                ),  if (file != null)
      SizedBox(height: 80,),
              Container(
                width: 158,
                height: 30,
                child: TextFormField(cursorColor: KSecondryColor,
                  decoration: InputDecoration(
                    focusColor: KSecondryColor,hoverColor: KSecondryColor,

                      fillColor: KSecondryColor,
                      hintText: '   Weight    ',
                      hintStyle:
                          TextStyle(fontSize: 16, color: KSecondryColor)),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "    Is Empty    ";
                    }
                    if (value.length > 4) {
                      return "    The weight cannot be large    ";
                    }
                  },
                ),
              ),SizedBox(height: 80,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButtom(
                  text: "Next",
                  onTap: () {
                    if (formstate.currentState!.validate()) {
                      print('valid');
                    } else {
                      print('not valid');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
