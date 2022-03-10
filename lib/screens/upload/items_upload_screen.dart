import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_store/global/global.dart';
import 'package:dash_store/model/menu.dart';
import 'package:dash_store/utils/constants.dart';
import 'package:dash_store/widgets/error_dialog.dart';
import 'package:dash_store/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;

class ItemsUploadScreen extends StatefulWidget {
  final Menu? model;
  ItemsUploadScreen({Key? key, this.model}) : super(key: key);

  @override
  State<ItemsUploadScreen> createState() => _ItemsUploadScreenState();
}

class _ItemsUploadScreenState extends State<ItemsUploadScreen> {
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  bool uploading = false;

  String uniqueIDName = DateTime.now().millisecondsSinceEpoch.toString();
  String itemImageUrl = '';

  defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'Add New Item for ${widget.model!.menuTitle}',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
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
                width: 250,
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
                  child: Text('Add New Item',
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

  itemsUploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title:
            Text('Uploading New Item', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            clearMenuUploadForm();
          },
        ),
        centerTitle: true,
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
                  hintText: 'Item Title',
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
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'description',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.money, color: Colors.grey),
            title: Container(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
                controller: priceController,
                decoration: InputDecoration(
                  hintText: 'price',
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
      descriptionController.clear();
      priceController.clear();
      imageXFile = null;
    });
  }

  validateUploadForm() async {
    setState(() {
      uploading = !uploading;
    });

    if (imageXFile != null) {
      if (descriptionController.text.isNotEmpty ||
          titleController.text.isNotEmpty ||
          priceController.text.isNotEmpty) {
        setState(() {
          uploading = true;
        });

        // uploading image
        String downloadUrl = await uploadImage(File(imageXFile!.path));

        // Save info to firebase_storage
        saveInfo(downloadUrl);
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
        storageRef.FirebaseStorage.instance.ref().child("items");
    storageRef.UploadTask uploadTask =
        reference.child(uniqueIDName + ".jpg").putFile(mImageFile);

    storageRef.TaskSnapshot tasksnapshot = await uploadTask.whenComplete(() {});

    String downloadURL = await tasksnapshot.ref.getDownloadURL();

    return downloadURL;
  }

  saveInfo(String downloadUrl) async {
    final ref = FirebaseFirestore.instance
        .collection('stores')
        .doc(sharedPreferences!.getString('uid'))
        .collection("menus")
        .doc(widget.model!.menuID)
        .collection("items");

    ref.doc(uniqueIDName).set({
      "itemID": uniqueIDName,
      "menuID": widget.model!.menuID,
      "storeUID": sharedPreferences!.getString('uid'),
      "storeName": sharedPreferences!.getString('name'),
      "itemTitle": titleController.text.toString(),
      "itemDescription": descriptionController.text.toString(),
      "price": int.parse(priceController.text),
      "itemImage": downloadUrl,
      "publishedDate": DateTime.now().toString(),
      "status": "available",
    }).then((value) {
      final itemRef = FirebaseFirestore.instance.collection("items");
      itemRef.doc(uniqueIDName).set({
        "itemID": uniqueIDName,
        "menuID": widget.model!.menuID,
        "storeUID": sharedPreferences!.getString('uid'),
        "storeName": sharedPreferences!.getString('name'),
        "itemTitle": titleController.text.toString(),
        "itemDescription": descriptionController.text.toString(),
        "price": int.parse(priceController.text),
        "itemImage": downloadUrl,
        "publishedDate": DateTime.now().toString(),
        "status": "available",
      });
    }).then((value) {
      clearMenuUploadForm();
      setState(() {
        uniqueIDName = DateTime.now().millisecondsSinceEpoch.toString();
        uploading = false;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return imageXFile == null ? defaultScreen() : itemsUploadFormScreen();
  }
}
