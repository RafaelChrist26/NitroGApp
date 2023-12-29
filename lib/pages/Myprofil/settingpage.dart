import 'package:flutter/material.dart';
import 'package:tugas_layout/Login/Auth/auth_service.dart';

class settingpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',
        style: TextStyle(fontFamily: 'Aclonica'),
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
                primary: Color.fromARGB(255, 45, 46, 46), // button background color
              ),
              onPressed: () {
                // Tambahkan logika untuk FAQ di sini
              },
              child: const Text(
                'Account Management',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 45, 46, 46), // button background color
              ),
              onPressed: () {
                // Tambahkan logika untuk FAQ di sini
              },
              child: Text(
                'FAQ',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 45, 46, 46), // button background color
              ),
              onPressed: () {
                // Tambahkan logika untuk Delete My Nitro Account di sini
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
                primary: Color.fromARGB(255, 45, 46, 46), // button background color
              ),
              onPressed: () {
                // Tambahkan logika logout di sini
                // Tampilkan dialog konfirmasi logout
                _showLogoutConfirmationDialog(context);

                // Setelah logout, kembali ke halaman login
                
              },
              child: Text(
                'Logout',
                style: TextStyle(color: const Color.fromARGB(255, 255, 0, 0)),
              ),
            ),
            // ... Add styles for other buttons similarly ...
          ],
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
                Navigator.of(context).pop(); // Tutup dialog tanpa logout
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Tambahkan logika logout di sini
                AuthService().logout(); // Harus diimplementasikan di AuthService

                // Setelah logout, kembali ke halaman login
                Navigator.pushReplacementNamed(context, '/login');
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
                Navigator.of(context).pop(); // Tutup dialog tanpa hapus akun
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Tambahkan logika hapus akun di sini
                try {
                  await AuthService().deleteAccount();
                  // Setelah hapus akun, kembali ke halaman login
                  Navigator.pushReplacementNamed(context, '/login');
                } catch (e) {
                  // Handle errors
                  print("Error deleting account: $e");
                  // You can display an error message or handle it in another way
                }
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
