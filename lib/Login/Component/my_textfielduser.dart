import 'package:flutter/material.dart';

class MyTextFieldUser extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextFieldUser({
    Key? key, // Menambahkan key sebagai parameter dan melewatkan ke superclass
    required this.controller,
    required this.hintText,
    required this.obscureText, required String? Function(dynamic value) validator,
  }) : super(key: key); // Melewatkan key ke superclass

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          fillColor: Color.fromARGB(255, 0, 0, 0),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: const Color.fromARGB(255, 100, 99, 99)), // Menambahkan warna tulisan petunjuk
        ),
      ),
    );
  }
}
