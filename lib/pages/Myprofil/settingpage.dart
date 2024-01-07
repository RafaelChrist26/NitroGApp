import 'package:flutter/material.dart';
import 'package:tugas_layout/Login/Auth/auth_service.dart';
import 'package:tugas_layout/pages/Myprofil/accmanagement.dart';
import 'package:tugas_layout/pages/Myprofil/Aboutus.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          // Custom back button behavior
          Navigator.pop(context);
          return false; // Prevents the default behavior of popping the route
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Settings',
                style: TextStyle(fontFamily: 'Aclonica', color: Colors.white)),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                // Navigate back to the "Myprofile" page
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 5, 38, 66),
                    Color.fromARGB(255, 71, 2, 110),
                    Color.fromARGB(255, 0, 0, 0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'SUPPORT',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 45, 46, 46),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AccountManagement()),
                    );
                  },
                  child: const Text(
                    'Account Management',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 45, 46, 46),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AboutUs()),
                    );
                    // Add logic for FAQ here
                  },
                  child: Text(
                    'About Us',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 45, 46, 46),
                  ),
                  onPressed: () {
                    _showDeleteAccountConfirmationDialog(context);
                  },
                  child: Text(
                    'Delete My Nitro Account',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 45, 46, 46),
                  ),
                  onPressed: () {
                    _showLogoutConfirmationDialog(context);
                  },
                  child: Text(
                    'Logout',
                    style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Close the dialog without logging out
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await AuthService().logout();
                // After logout, navigate to the login page
                Navigator.pushReplacementNamed(context, '/login');
              } catch (e) {
                print("Error logging out: $e");
                // Handle errors, display an error message, or handle it in another way
              }
            },
            child: Text('Logout'),
          ),
        ],
      );
    },
  );
}

Future<void> _showDeleteAccountConfirmationDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete My Nitro Account'),
        content: Text('Are you sure you want to delete your Nitro account?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Close the dialog without deleting the account
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await AuthService().deleteAccount();
                // After deleting the account, navigate to the login page
                Navigator.pushReplacementNamed(context, '/login');
              } catch (e) {
                print("Error deleting account: $e");
                // Handle errors, display an error message, or handle it in another way
              }
            },
            child: Text('Delete'),
          ),
        ],
      );
    },
  );
}
