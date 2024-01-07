import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tugas_layout/Login/Admin/Adminpage.dart';
import 'package:tugas_layout/Login/Auth/auth_service.dart';
import 'package:tugas_layout/Login/Auth/usernamepage.dart';
import 'package:tugas_layout/Login/Component/my_textfieldpass.dart';
import 'package:tugas_layout/Login/Password/updatepass.dart';
import 'package:tugas_layout/Login/Component/my_button.dart';
import 'package:tugas_layout/Login/Component/my_textfield.dart';
import 'package:tugas_layout/Login/register.dart';
import 'package:tugas_layout/Login/Component/square_tile.dart';
import 'package:tugas_layout/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tugas_layout/pages/formDataUpload.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Image.asset(
                    "lib/icons/logoapp.png",
                    color: Colors.white,
                    height: 100,
                  ),
                  SizedBox(height: 20),
                  const Text(
                    "Game On, Anywhere You Go!",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Aclonica',
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 20),
                  MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),
                  SizedBox(height: 10),
                  MyTextFieldpass(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPasswordPage(),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Forgot Password?",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  MyButton(
                    ontap: () async {
                      try {
                        FirebaseAuth _auth = FirebaseAuth.instance;
                        UserCredential userCredential =
                            await _auth.signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        if (userCredential.user != null) {
                          if (userCredential.user!.email == 'admin@admin.com') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UploadTes(),
                                ));
                          }
                        } if (userCredential.user!.email != 'admin@admin.com') {
                          final message = await AuthService().login(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          if (message == 'Login Success') {
                            // Check if the user has set up their account details in Firestore
                            bool isAccountSetUp =
                                await AuthService().isAccountSetUp();

                            if (isAccountSetUp) {
                              // If account details are set up, navigate to the homepage
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyHomePage(), // Replace with your homepage
                                ),
                              );
                            } else {
                              // If account details are not set up, navigate to the UsernamePage
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UsernamePage(),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message ?? 'An error occurred'),
                              ),
                            );
                          }
                        }
                      } catch (e) {}
                    },
                  ),
                  SizedBox(height: 50),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "or continue with",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          final googleSignIn = GoogleSignIn();

                          // Meminta pengguna untuk memilih akun Google
                          final googleSignInAccount =
                              await googleSignIn.signIn();

                          // Check apakah pengguna memilih akun atau tidak
                          if (googleSignInAccount != null) {
                            final message = await AuthService()
                                .signInWithGoogle(googleSignInAccount);

                            // Jika login berhasil, pindahkan ke halaman beranda
                            if (message == 'Login Success') {
                              bool isAccountSetUp =
                                  await AuthService().isAccountSetUp();

                              if (isAccountSetUp) {
                                // If account details are set up, navigate to the homepage
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MyHomePage(), // Replace with your homepage
                                  ),
                                );
                              } else {
                                // If account details are not set up, navigate to the UsernamePage
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UsernamePage(),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(message ?? 'An error occurred'),
                                ),
                              );
                            }
                          }
                        },
                        child: const SquareTile(
                          imagePath: 'lib/icons/google.png',
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 40),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "New to Nitro?",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Create Account",
                          style: TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                      ],
                    ),
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
