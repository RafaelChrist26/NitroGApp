
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class testUpload extends StatefulWidget {
  const testUpload({super.key});

  @override
  State<testUpload> createState() => _testUploadState();
}

class _testUploadState extends State<testUpload> {
 final ImagePicker _imagePicker = ImagePicker();
  PickedFile? _pickedFile;

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      _pickedFile = pickedFile;
    });

    if (_pickedFile != null) {
      // Upload the image to Firestore
      await _uploadImageToFirestore(File(_pickedFile!.path));
    }
  }

  Future<void> _uploadImageToFirestore(File file) async {
    // Get a reference to the Firebase storage bucket
    Reference storageReference = FirebaseStorage.instance.ref().child('images/${DateTime.now().toString()}');

    // Upload the file to Firebase Storage
    UploadTask uploadTask = storageReference.putFile(file);

    // Get the download URL of the uploaded file
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    // Save the download URL to Firestore
    await FirebaseFirestore.instance.collection('images').add({
      'url': downloadURL,
    });

    print('Image uploaded to Firestore: $downloadURL');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _pickedFile == null
                ? Text('No image selected.')
                : Image.file(File(_pickedFile!.path)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
          ],
        ),
      ),
    );
  }
}
