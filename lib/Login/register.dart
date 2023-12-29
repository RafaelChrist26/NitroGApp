import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tugas_layout/Login/Auth/auth_service.dart';
import 'package:tugas_layout/Login/login.dart';
import 'package:tugas_layout/Login/Component/my_button.dart';
import 'package:tugas_layout/Login/Component/my_textfield.dart';
import 'package:tugas_layout/Login/Component/square_tile.dart';
import 'package:tugas_layout/main.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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

                  //logo
                  Image.asset(
                    "lib/icons/logoapp.png",
                    color: Colors.white,
                    height: 100,
                  ),
                  SizedBox(height: 20),
                  // pembuka
                  const Text(
                    "Create Your Nitro Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Aclonica',
                      fontSize: 20,
                    ),
                  ),

                  SizedBox(height: 20),
                  // email Textfield
                  MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),

                  SizedBox(height: 10),
                  // Password
                  MyTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                  ),

                  SizedBox(height: 10),
                  // Confirm Password
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    obscureText: true,
                  ),

                  //button register
                  SizedBox(height: 20),
                  MyButton(
                    ontap: () async {
                      if (passwordController.text == confirmPasswordController.text) {
                        final message = await AuthService().register(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        // Navigasi ke halaman beranda setelah registrasi berhasil
                        if (message == 'Registration Success') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message ?? 'An error occurred'),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Password and Confirm Password do not match'),
                          ),
                        );
                      }
                    },
                  ),

                  //login with
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
                  //app logo
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyHomePage(), // Ganti dengan halaman beranda yang sesuai
                                ),
                              );
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

                  // Login
                  SizedBox(height: 40),
                  InkWell(
                    onTap: () {
                      // Navigasi kembali ke halaman login
                      Navigator.pop(context);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          "Login",
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
