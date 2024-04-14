import 'dart:ffi';
import 'dart:io';
import 'package:breadapp/constants.dart';
import 'package:breadapp/widgets/custom_buttom.dart';
import 'package:breadapp/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      vsync: this,
    );
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        controller.reset();
      }
    });
  }

  File? file;
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
                    animate: true,
                    repeat: false,
                    controller: controller, onLoaded: (composition) {
                  controller.duration = composition.duration;
                  controller.forward();
                }),
              ],
            ),
          ));

  final storageRef = FirebaseStorage.instance.ref();
// upload data function
  bool isLoading = false;
  Future<void> uploadData() async {
    if (file == null ||
        selectedbreadquality == null ||
        selectedbreadweight == null) return;

    final String userId = FirebaseAuth.instance.currentUser!.uid;
    final String imageFileName =
        DateTime.now().millisecondsSinceEpoch.toString();
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('images/$imageFileName.jpg');

    // Compress image if necessary
    // final compressedFile = await compressImage(file!);

    isLoading = true;
    setState(() {});

    try {
      final imageUrlFuture = storageRef.putFile(file!);
      final imageUrl = await (await imageUrlFuture).ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('bread_data').doc().set({
        'userId': userId,
        'imageUrl': imageUrl,
        'breadQuality': selectedbreadquality,
        'breadWeight': selectedbreadweight,
        'timestamp': FieldValue.serverTimestamp(),
      });

      showDoneDialog();
    } catch (e) {
      print('Error uploading data: $e');
    } finally {
      isLoading = false;
      selectedbreadquality == null;
      selectedbreadweight == null;
      file == null;
      setState(() {});
    }
  }

  getImage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
//final XFile? imageGallery = await picker.pickImage(source: ImageSource.gallery);
// Capture a photo.
    final XFile? imageCamera =
        await picker.pickImage(source: ImageSource.camera);
    if (imageCamera != null) {
      file = File(imageCamera.path);
      var refStorage = FirebaseStorage.instance.ref("");
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
            icon: const Icon(Icons.exit_to_app_outlined))
     ]),
      body: isLoading == true
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ' Sending data ',
                  style: TextStyle(fontSize: 16, color: KSecondryColor),
                ),
                Center(
                  child: Dialog(
                    child: LinearProgressIndicator(
                      semanticsLabel: "Sending data",
                    ),
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
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
                              padding: const EdgeInsets.all(32),
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
                    const SizedBox(
                      height: 80,
                    ),
                    if (file != null)
                      Container(
                        height: 110,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: KSecondryColor)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Choose Quality',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: KSecondryColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: KPrimaryColor,
                                child: DropdownButton(
                                  underline: const Divider(
                                    thickness: 1,
                                    color: KSecondryColor,
                                  ),
                                  iconEnabledColor: KSecondryColor,
                                  iconSize: 30,
                                  hint: const Padding(
                                    padding: EdgeInsets.all(2),
                                    child: SizedBox(
                                      height: 90,
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 0),
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
                                  style: const TextStyle(color: KSecondryColor),
                                  dropdownColor: KPrimaryColor,
                                  borderRadius: BorderRadius.circular(16),
                                  items: [
                                    "Average",
                                    "Good",
                                    "Bad",
                                  ]
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
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
                      const SizedBox(
                        height: 80,
                      ),
                    if (file != null)
                      Container(
                        height: 110,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: KSecondryColor)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Enter Weight',
                              style: TextStyle(
                                 fontWeight: FontWeight.w700,
                                color: KSecondryColor,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 158,
                              height: 30,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                onSaved: (val) {
                                  selectedbreadweight = val;
                                },
                                cursorColor: KSecondryColor,
                                decoration: const InputDecoration(
                                    focusColor: KSecondryColor,
                                    hoverColor: KSecondryColor,
                                    fillColor: KSecondryColor,
                                    hintText: 'Weight',
                                    hintStyle: TextStyle(
                                        fontSize: 18, color: KSecondryColor)),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {value=null;
                                    return "    Is Empty    ";
                                    
                                  }
                                  if (value.length > 4) {
                                    return "Enter a Valid Number";
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 80,
                    ),
                    if (file != null && selectedbreadquality != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                          
                          text: "Send",
                          onTap: () {
                            if (formstate.currentState!.validate()) {
                              formstate.currentState!.save();
                              uploadData();
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
