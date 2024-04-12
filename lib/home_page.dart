import 'dart:io';

import 'package:breadapp/constants.dart';
import 'package:breadapp/widgets/custom_buttom.dart';
import 'package:breadapp/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
     
      vsync: this,);
      controller.addStatusListener((status) async {
        if(status==AnimationStatus.completed){
          Navigator.pop(context);
          controller.reset();
        }
      });
    
  }
  @override

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void showDoneDialog() => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset('animations/success.json',
                    animate: true, repeat: false, controller: controller,
                    onLoaded: (composition){
                      controller.duration=composition.duration;
                      controller.forward();
                    }),
              ],
            ),
          ));

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

  String? selectedbreadquality;
  String? selectedbreadweight;
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
              SizedBox(
                height: 80,
              ),
              if (file != null)
                Container(
                  height: 85,
                  width: 315,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: KSecondryColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Choose Quality :',
                        style: TextStyle(
                          color: KSecondryColor,
                          fontSize: 18,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: KPrimaryColor,
                          child: DropdownButton(
                            underline: Divider(
                              thickness: 1,
                              color: KSecondryColor,
                            ),
                            iconEnabledColor: KSecondryColor,
                            iconSize: 30,
                            hint: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Container(
                                height: 90,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 0),
                                  child: Text(
                                    "Choose Quality",
                                    style: TextStyle(
                                      color: KSecondryColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            style: TextStyle(color: KSecondryColor),
                            dropdownColor: KPrimaryColor,
                            borderRadius: BorderRadius.circular(16),
                            items: ["Average", "Good", "Bad",]
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
                                selectedbreadquality = val;
                              });
                            },
                            value: selectedbreadquality,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (file != null)
                SizedBox(
                  height: 80,
                ),
              if (file != null)
                Container(
                  height: 85,
                  width: 315,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: KSecondryColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Enter Weight : ',
                        style: TextStyle(
                          color: KSecondryColor,
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        width: 158,
                        height: 30,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          onSaved: (val) {
                            selectedbreadweight = val;
                          },
                          cursorColor: KSecondryColor,
                          decoration: InputDecoration(
                              focusColor: KSecondryColor,
                              hoverColor: KSecondryColor,
                              fillColor: KSecondryColor,
                              hintText: '   Weight    ',
                              hintStyle: TextStyle(
                                  fontSize: 18, color: KSecondryColor)),
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
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: 80,
              ),
              if (file != null && selectedbreadquality != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButtom(
                    text: "Send",
                    onTap: () {
                      if (formstate.currentState!.validate()) {
                        formstate.currentState!.save();
                        showDoneDialog();
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
