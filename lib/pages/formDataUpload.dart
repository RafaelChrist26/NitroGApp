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
  List<OsOption> _osOptions = [
    OsOption(
        name: 'Windows',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/c/c1/Windows_icon_logo.png',
        selected: false),
    OsOption(
        name: 'MacOS',
        imageUrl: 'https://www.iconsdb.com/icons/preview/white/mac-os-xxl.png',
        selected: false),
    OsOption(
        name: 'Linux',
        imageUrl: 'https://www.iconsdb.com/icons/preview/white/linux-xxl.png',
        selected: false),
  ];
  TextEditingController _gameTitleController = TextEditingController();
  TextEditingController _gameHargaController = TextEditingController();
  TextEditingController _gameGenreController = TextEditingController();
  TextEditingController _gameDiskonController = TextEditingController();
  TextEditingController _gameDeveloperController = TextEditingController();
  TextEditingController _gamePubliserController = TextEditingController();
  TextEditingController _gameReleasedController = TextEditingController();
  TextEditingController _gameDescriptionController = TextEditingController();

  // Mendapatkan referensi ke instance Firebase Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Upload Game Store',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Aclonica',
              fontWeight: FontWeight.bold,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 5, 38, 66),
                  Color.fromARGB(255, 71, 2, 110),
                  Color.fromARGB(255, 0, 0, 0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              // Handle back button press
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Welcome back Admin, Time to get some Game!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: _gameTitleController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Judul Game',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _gameHargaController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Harga Game',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _gameGenreController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: 'Genre Game',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _gameDeveloperController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: 'Developer Game',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _gamePubliserController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: 'Publisher Game',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _gameReleasedController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: 'Released Game',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _gameDescriptionController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: 'Description Game',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _gameDiskonController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: 'Diskon Game',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 20),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                  ),
                  child: Text('Upload Gambar Game'),
                ),
                SizedBox(height: 20),
                _imageUrls.isEmpty
                    ? Text(
                        'Tidak ada gambar yang dipilih',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Aclonica',
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: _imageUrls
                            .map((url) => Image.network(url,
                                width: 100, height: 100, fit: BoxFit.cover))
                            .toList(),
                      ),
                SizedBox(height: 20),
                Text('Pilih Gambar OS',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Aclonica',
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 20),
                _osOptions.isEmpty
                    ? Text(
                        'Tidak ada gambar yang dipilih',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Aclonica',
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: _osOptions
                            .map(
                              (osOption) => OsSelectionTile(
                                osOption: osOption,
                                onTap: () {
                                  setState(() {
                                    osOption.selected = !osOption.selected;
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _uploadGameDataAndImage,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                  ),
                  child: Text('Unggah Data Game dan Gambar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _uploadImageData() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String documentId = DateTime.now().millisecondsSinceEpoch.toString();
      _uploadImageToFirestore(File(pickedFile.path), documentId);
    }
  }

  Future<void> _uploadImageDataOs() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String documentId = DateTime.now().millisecondsSinceEpoch.toString();
      _uploadImageOsToFirestore(File(pickedFile.path), documentId);
    }
  }

  Future<void> _uploadImageOsToFirestore(File file, String documentId) async {
    String fileName = 'images/$documentId.jpg';
    firebase_storage.Reference storageReference =
        firebase_storage.FirebaseStorage.instance.ref().child(fileName);

    firebase_storage.UploadTask uploadTask = storageReference.putFile(file);

    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => null);
    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      _osOptions
          .where((osOption) => osOption.selected)
          .forEach((osOption) => osOption.imageUrl = downloadURL);
    });

    print('Tautan gambar diunggah ke Firestore: $downloadURL');
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

  Future<void> _pickImageOs() async {
    await _uploadImageDataOs();
  }

  Future<void> _pickImage() async {
    await _uploadImageData();
  }

  Future<void> _uploadGameDataAndImage() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String documentId = DateTime.now().millisecondsSinceEpoch.toString();

      String gameTitle = _gameTitleController.text.trim();
      int gameHarga = int.tryParse(_gameHargaController.text.trim()) ?? 0;
      String gameGenre = _gameGenreController.text.trim();
      String gameDeveloper = _gameDeveloperController.text.trim();
      String gamePubliser = _gamePubliserController.text.trim();
      String gameReleased = _gameReleasedController.text.trim();
      String gameDescription = _gameDescriptionController.text.trim();
      int gameDiskon = int.tryParse(_gameDiskonController.text.trim()) ?? 0;

      await FirebaseFirestore.instance.collection('stores').add(
        {
          'documentId': documentId,
          'gameTitle': gameTitle,
          'gameHarga': gameHarga,
          'gameGenre': gameGenre,
          'gameDeveloper': gameDeveloper,
          'gamePubliser': gamePubliser,
          'gameReleased': gameReleased,
          'gameDescription': gameDescription,
          'gameDiskon': gameDiskon,
          'imageUrl': _imageUrls.isNotEmpty ? _imageUrls.first : null,
          'os': _osOptions
              .where((osOption) => osOption.selected)
              .map((osOption) => osOption.imageUrl)
              .toList(),
        },
      );

      print(
          'Data game dan gambar diunggah ke Firestore untuk dokumen baru: $documentId');

      _gameTitleController.clear();
      _gameHargaController.clear();
      _gameGenreController.clear();
      _gameDiskonController.clear();

      setState(() {
        _imageUrls.clear();
        _osOptions.forEach((osOption) => osOption.selected = false);
      });
    }
  }
}

class OsOption {
  final String name;
  String imageUrl;
  bool selected;

  OsOption(
      {required this.name, required this.imageUrl, required this.selected});
}

class OsSelectionTile extends StatelessWidget {
  final OsOption osOption;
  final VoidCallback onTap;

  OsSelectionTile({required this.osOption, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.network(
            osOption.imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Checkbox(
            value: osOption.selected,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
