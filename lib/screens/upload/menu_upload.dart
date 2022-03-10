import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_store/global/global.dart';
import 'package:dash_store/utils/constants.dart';
import 'package:dash_store/widgets/error_dialog.dart';
import 'package:dash_store/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;

class MenuUploadScreen extends StatefulWidget {
  MenuUploadScreen({Key? key}) : super(key: key);

  @override
  State<MenuUploadScreen> createState() => _MenuUploadScreenState();
}

class _MenuUploadScreenState extends State<MenuUploadScreen> {
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  TextEditingController shortInfoController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  bool uploading = false;

  String uniqueIDName = DateTime.now().millisecondsSinceEpoch.toString();
  String itemImageUrl = '';

  defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey,
        title: Row(
          children: [
            Text('Add New Item Category', style: TextStyle(color: Colors.black)),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shop_two, color: Colors.grey, size: 200),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Constants.secondary_color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  onPressed: () {
                    takeImage(context);
                  },
                  child: Text('Add New Item Category',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  takeImage(mContext) {
    return showDialog(
        context: mContext,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              "Menu Image",
              style: TextStyle(color: Colors.black),
            ),
            children: [
              SimpleDialogOption(
                child: Text(
                  "Take Photo",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: captureImageWithCamera,
              ),
              SimpleDialogOption(
                child: Text(
                  "Choose From Gallery",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: pickImageFromGallery,
              ),
              SimpleDialogOption(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  captureImageWithCamera() async {
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 1200,
        maxHeight: 720);

    setState(() {
      imageXFile;
    });
  }

  pickImageFromGallery() async {
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 1200,
        maxHeight: 720);

    setState(() {
      imageXFile;
    });
  }

  menuUploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey,
        title:
            Text('Uploading New Item', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            clearMenuUploadForm();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Constants.secondary_color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
              onPressed: () {
                uploading ? null : validateUploadForm();
              },
              child: Row(
                children: [
                  Text(
                    'Add',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.add, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          uploading == true ? linearProgress() : Container(),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.8,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      image: FileImage(
                        File(imageXFile!.path),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.food_bank, color: Colors.grey),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Menu Title',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.perm_device_info, color: Colors.grey),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: shortInfoController,
                decoration: InputDecoration(
                  hintText: 'description',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  clearMenuUploadForm() {
    setState(() {
      titleController.clear();
      shortInfoController.clear();
      imageXFile = null;
    });
  }

  validateUploadForm() async {
    setState(() {
      uploading = !uploading;
    });

    if (imageXFile != null) {
      if (shortInfoController.text.isNotEmpty ||
          titleController.text.isNotEmpty) {
        setState(() {
          uploading = true;
        });

        // uploading image
        String downloadUrl = await uploadImage(File(imageXFile!.path));

        // Save info to firebase_storage
        saveInfo(downloadUrl, shortInfoController.text, titleController.text);
      } else {
        setState(() {
          uploading = false;
        });
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(message: "Please Input all fields");
            });
      }
    } else {
      setState(() {
        uploading = false;
      });
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(message: "Please Select An Image");
          });
    }
  }

  uploadImage(mImageFile) async {
    storageRef.Reference reference =
        storageRef.FirebaseStorage.instance.ref().child("menus");
    storageRef.UploadTask uploadTask =
        reference.child(uniqueIDName + ".jpg").putFile(mImageFile);

    storageRef.TaskSnapshot tasksnapshot = await uploadTask.whenComplete(() {});

    String downloadURL = await tasksnapshot.ref.getDownloadURL();

    return downloadURL;
  }

  saveInfo(String downloadUrl, String shortInfo, String titleMenu) async {
    final ref = FirebaseFirestore.instance
        .collection('stores')
        .doc(sharedPreferences!.getString('uid'))
        .collection("menus");

    ref.doc(uniqueIDName).set({
      "menuID": uniqueIDName,
      "storeUID": sharedPreferences!.getString('uid'),
      "menuTitle": titleMenu,
      "menuInfo": shortInfo,
      "menuImage": downloadUrl,
      "publishedDate": DateTime.now().toString(),
      "status": "available",
    });

    clearMenuUploadForm();
    setState(() {
      uniqueIDName =DateTime.now().millisecondsSinceEpoch.toString();
      uploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return imageXFile == null ? defaultScreen() : menuUploadFormScreen();
  }
}
