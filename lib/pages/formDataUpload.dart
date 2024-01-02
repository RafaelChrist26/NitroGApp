import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadTes extends StatefulWidget {
  const UploadTes({Key? key}) : super(key: key);

  @override
  State<UploadTes> createState() => _UploadTesState();
}

class _UploadTesState extends State<UploadTes> {
   final ImagePicker _imagePicker = ImagePicker();
  List<String> _imageUrls = [];
  TextEditingController _gameTitleController = TextEditingController();
  TextEditingController _gameHargaController = TextEditingController();
  TextEditingController _gameGenreController = TextEditingController();
  TextEditingController _gameDiskonController = TextEditingController();

  // Mendapatkan referensi ke instance Firebase Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Upload Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 20),
              TextField(
                controller: _gameTitleController,
                decoration: InputDecoration(labelText: 'Judul Game'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _gameHargaController,
                decoration: InputDecoration(labelText: 'Harga Game'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _gameGenreController,
                decoration: InputDecoration(labelText: 'Genre Game'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _gameDiskonController,
                decoration: InputDecoration(labelText: 'Diskon Game'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pilih Gambar'),
              ),
              SizedBox(height: 20),
              _imageUrls.isEmpty
                  ? Text('Tidak ada gambar yang dipilih.')
                  : Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: _imageUrls
                          .map((url) => Image.network(url,
                              width: 100, height: 100, fit: BoxFit.cover))
                          .toList(),
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadGameDataAndImage,
                child: Text('Unggah Data Game dan Gambar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _uploadImageData() async {
    final pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String documentId = DateTime.now().millisecondsSinceEpoch.toString();
      _uploadImageToFirestore(File(pickedFile.path), documentId);
    }
  }

  Future<void> _uploadImageToFirestore(File file, String documentId) async {
    String fileName = 'images/$documentId.jpg';
    firebase_storage.Reference storageReference =
        firebase_storage.FirebaseStorage.instance.ref().child(fileName);

    firebase_storage.UploadTask uploadTask = storageReference.putFile(file);

    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => null);
    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      _imageUrls.clear();
      _imageUrls.add(downloadURL);
    });

    print('Tautan gambar diunggah ke Firestore: $downloadURL');
  }

  Future<void> _pickImage() async {
    await _uploadImageData();
  }

  Future<void> _uploadGameDataAndImage() async {
  User? user = _auth.currentUser;
  if (user != null) {
    String documentId = DateTime.now().millisecondsSinceEpoch.toString();

    String gameTitle = _gameTitleController.text.trim();
    String gameHarga = _gameHargaController.text.trim();
    String gameGenre = _gameGenreController.text.trim();
    String gameDiskon = _gameDiskonController.text.trim();

    await FirebaseFirestore.instance.collection('stores').add(
      {
        'documentId': documentId, // Tambahkan ID dokumen
        'gameTitle': gameTitle,
        'gameHarga': gameHarga,
        'gameGenre': gameGenre,
        'gameDiskon': gameDiskon,
        'imageUrl': _imageUrls.isNotEmpty ? _imageUrls.first : null,
      },
    );

    print('Data game dan gambar diunggah ke Firestore untuk dokumen baru: $documentId');

    _gameTitleController.clear();
    _gameHargaController.clear();
    _gameGenreController.clear();
    _gameDiskonController.clear();

    setState(() {
      _imageUrls.clear();
    });
  }
}
}
