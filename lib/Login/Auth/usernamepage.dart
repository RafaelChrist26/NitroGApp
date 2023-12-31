import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tugas_layout/Login/Auth/auth_service.dart';
import 'package:tugas_layout/Login/Component/my_buttonusername.dart';
import 'package:tugas_layout/Login/Component/my_textfield.dart';
import 'package:tugas_layout/Login/Component/my_textfielduser.dart';
import 'package:tugas_layout/main.dart';

class UsernamePage extends StatelessWidget {
  UsernamePage({Key? key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<String> errorText = ValueNotifier<String>('');

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
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 50),

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
                        if (formKey.currentState!.validate()) {
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
                              'name': usernameController.text,
                              // Set username here
                              // 'email': emailController.text,  // Add other fields as needed
                              // Add other fields as needed
                            });

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

                    // ... (Other widgets)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
