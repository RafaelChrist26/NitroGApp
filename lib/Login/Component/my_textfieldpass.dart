import 'package:flutter/material.dart';

class MyTextFieldpass extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextFieldpass({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyTextFieldpassState createState() => _MyTextFieldpassState();
}

class _MyTextFieldpassState extends State<MyTextFieldpass> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: widget.controller,
        obscureText: !_showPassword && widget.obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          fillColor: Color.fromARGB(255, 0, 0, 0),
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: const Color.fromARGB(255, 100, 99, 99)),
          suffixIcon: IconButton(
            icon: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
          ),
        ),
      ),
    );
  }
}
