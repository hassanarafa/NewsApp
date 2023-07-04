import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  File? file;
  ImagePicker image = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Choose'),
                      content: SizedBox(
                        height: 70,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                IconButton(
                                    icon: const Icon(Icons.storage),
                                    onPressed: () {
                                      Navigator.pop(context, 'Cancel');
                                      getgal();
                                    }),
                                const Text("Gallary")
                              ],
                            ),
                            const SizedBox(width: 110),
                            Column(
                              children: [
                                IconButton(
                                    icon: const Icon(Icons.camera),
                                    onPressed: () {
                                      Navigator.pop(context, 'Cancel');
                                      getcam();
                                    }),
                                const Text("Camera")
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              child: file == null
                  ? const CircleAvatar(radius: 100, child: Icon(Icons.image))
                  : CircleAvatar(
                      radius: 100,
                      backgroundImage: FileImage(file!),
                    ))
        ],
      ),
    );
  }

  getcam() async {
    var img = await image.pickImage(source: ImageSource.camera);
    setState(() {
      file = File(img!.path);
    });
  }

  getgal() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }
}

// Container(
//                     height: 500,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black, width: 50),
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: ,
//                   ),