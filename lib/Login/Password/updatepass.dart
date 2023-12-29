import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tugas_layout/Login/login.dart';
import 'package:tugas_layout/Login/Component/my_buttonpass.dart';
import 'package:tugas_layout/Login/Component/my_textfield.dart';


class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
  try {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text.trim());

    // Show success dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Password reset email has been sent. Check your email.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to the login page
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } on FirebaseAuthException catch (e) {
    print(e);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      },
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 20),

                  // Email Textfield
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  // Button Reset Password
                  SizedBox(height: 20),
                  MyButtonpass(
                    ontap: resetPassword,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
