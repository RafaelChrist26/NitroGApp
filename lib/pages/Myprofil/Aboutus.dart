import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'About Us',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Aclonica',
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // Navigate back to the "Myprofile" page
              Navigator.pushReplacementNamed(context, '/settings');
            },
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 5, 38, 66),
                  Color.fromARGB(255, 71, 2, 110),
                  Color.fromARGB(255, 0, 0, 0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Our App!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'At Our App, we are dedicated to providing the best user experience and delivering high-quality content to our users.',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              SizedBox(height: 16.0),
              Text(
                'Our Mission',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Our mission is to create innovative solutions that cater to the needs of our users and make their lives easier. We aim to build a community where everyone can connect and share their experiences.',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              SizedBox(height: 16.0),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                'If you have any questions or feedback, please feel free to contact us at info@ourapp.com. We appreciate your support!',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              SizedBox(height: 40.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Image.asset(
                    'lib/icons/logoapp.png', // Replace with the path to your logo image
                    color: Colors.white,
                    width: 1000, // Adjust the width of the logo as needed
                    height: 100, // Adjust the height of the logo as needed
                    // You can also use other widgets like Icon or SvgPicture instead of Image
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
