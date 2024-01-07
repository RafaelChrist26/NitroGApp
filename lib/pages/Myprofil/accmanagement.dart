import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class AccountManagement extends StatefulWidget {
  @override
  _AccountManagementState createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagement> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final ValueNotifier<String> errorText = ValueNotifier<String>('');
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  File? _image;
  String _currentUsername = '';
  String _currentStatus = '';
  String _currentPictureUrl = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _currentUsername = data['name'];
          _currentStatus =
              data['status'] ?? ''; // Use empty string if status is null
          _currentPictureUrl = data['picture'];
        });
      }
    }
  }

  Future<void> _updateUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final uid = user.uid;
        final docRef = FirebaseFirestore.instance.collection('users').doc(uid);

        // Check if the username is changed, and update it in Firestore
        if (usernameController.text.isNotEmpty &&
            usernameController.text != _currentUsername) {
          await docRef.update({'name': usernameController.text});
          _currentUsername = usernameController.text;
        }

        // Check if the status is changed, and update it in Firestore
        if (statusController.text != _currentStatus) {
          await docRef.update({'status': statusController.text});
          _currentStatus = statusController.text;
        }

        // Check if the image is changed, and update it in Firestore and Storage
        if (_image != null) {
          final bytes = await _image!.readAsBytes();
          final imageUrl = await _uploadImageToStorage(bytes);
          await docRef.update({'picture': imageUrl});
          _currentPictureUrl = imageUrl;
        }

        // Tampilkan notifikasi bahwa profil telah diupdate
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profil Anda Telah Diperbarui'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print('Error updating user data: $error');
      errorText.value = 'Failed to update user data';
    }
  }

  Future<String> _uploadImageToStorage(List<int> bytes) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final imagePath = 'images/$timestamp.jpg';
      final storageReference = _storage.ref().child(imagePath);
      final uploadTask = storageReference.putData(Uint8List.fromList(bytes));
      await uploadTask.whenComplete(() {});
      return await storageReference.getDownloadURL();
    } catch (error) {
      print('Error uploading image to Firebase Storage: $error');
      return '';
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Account Management',
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
              Navigator.pushReplacementNamed(context, '/settings');
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Display current profile picture
                // Display current profile picture
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: ClipOval(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: _image != null
                          ? Image.memory(
                              Uint8List.fromList(_image!.readAsBytesSync()),
                              fit: BoxFit.cover,
                            )
                          : _currentPictureUrl.isNotEmpty
                              ? Image.network(
                                  _currentPictureUrl,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'lib/icons/user.png',
                                  fit: BoxFit.cover,
                                ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // Button to pick a new profile picture
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick New Profile Picture'),
                ),
                SizedBox(height: 10),

                // Form to update username and status
                TextFormField(
                  controller: usernameController,
                  style: TextStyle(
                      color: Colors
                          .white), // Atur warna teks input sesuai keinginan
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter new username',
                    labelStyle: TextStyle(
                        color: Colors
                            .white), // Atur warna teks label sesuai keinginan
                  ),
                ),

                SizedBox(height: 10),
                TextFormField(
                  controller: statusController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Status',
                    hintText: 'Enter new status',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),

                // Show error message
                ValueListenableBuilder<String>(
                  valueListenable: errorText,
                  builder: (context, value, child) {
                    return Text(
                      value,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),

                // Button to update user data
                ElevatedButton(
                  onPressed: _updateUserData,
                  child: Text('Update User Data'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
