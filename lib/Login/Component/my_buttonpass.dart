import 'package:flutter/material.dart';

class MyButtonpass extends StatelessWidget {
  final Function()? ontap;
  const MyButtonpass({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 34, 146, 238),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            "Check your Email",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
