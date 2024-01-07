import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Admin Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue, // Set your desired app bar color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome Admin!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your admin-specific functionality here
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Set your desired button color
              ),
              child: Text('Admin Functionality'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your logout functionality here
                Navigator.pop(context); // Navigate back to the login page
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Set your desired button color
              ),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
