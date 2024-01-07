import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tugas_layout/Login/Component/my_buttonusername.dart';
import 'package:tugas_layout/Login/Component/my_textfielduser.dart';
import 'package:tugas_layout/main.dart';

class UsernamePage extends StatefulWidget {
  UsernamePage({Key? key}) : super(key: key);

  @override
  _UsernamePageState createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  void setPictureUrl(String url) {
    setState(() {
      _pictureUrl = url;
    });
  }

  final _formKey = GlobalKey<FormState>();
  String _pictureUrl = '';
  final TextEditingController usernameController = TextEditingController();
  final ValueNotifier<String> errorText = ValueNotifier<String>('');
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  File? _image; // Variable to store the selected image file

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),

                    // Circular avatar for image display
                    GestureDetector(
                      onTap: () async {
                        final pickedFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          final bytes = await pickedFile.readAsBytes();
                          final imageUrl = await _uploadImageToStorage(bytes);
                          setState(() {
                            _image = File(pickedFile
                                .path); // Update _image with the picked file
                            _pictureUrl = imageUrl;
                          });
                        }
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _image != null
                            ? Image.file(_image!).image
                            : AssetImage('lib/icons/user.png'),
                      ),
                    ),

                    SizedBox(height: 10),

                    // Input username
                    MyTextFieldUser(
                      controller: usernameController,
                      obscureText: false,
                      hintText: 'Username',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
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

                    // Register button
                    MyButtonusername(
                      ontap: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            // 1. Create user account
                            String? uid = '';
                            if (FirebaseAuth.instance.currentUser != null) {
                              uid = FirebaseAuth.instance.currentUser?.uid;
                            }

                            // 2. Add user data to Firestore, including username
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .set({
                              'picture': _pictureUrl,
                              'name': usernameController.text,
                              // Set username here
                            });
                            // _submitForm();

                            // 3. Handle registration success
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                            );
                          } catch (error) {
                            // Handle registration errors
                            if (error is FirebaseAuthException) {
                              if (error.code == 'email-already-in-use') {
                                // Email already in use
                                errorText.value = 'Email already in use';
                              } else {
                                // Other errors
                                errorText.value = 'An error occurred';
                              }
                            } else {
                              // Unknown errors
                              errorText.value = 'Unknown error occurred';
                            }
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  Future<String> _uploadImageToStorage(List<int> bytes) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final imagePath = 'images/$timestamp.jpg';
      final storageReference = _storage.ref().child(imagePath);
      final uploadTask = storageReference.putData(Uint8List.fromList(bytes));

      // Wait for the upload to complete
      await uploadTask.whenComplete(() {});

      // Get the download URL from the storage reference
      final imageUrl = await storageReference.getDownloadURL();

      return imageUrl;
    } catch (error) {
      print('Error uploading image to Firebase Storage: $error');
      // Handle error as needed
      return '';
    }
  }
}
