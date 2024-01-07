import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';


final FirebaseAuth _auth = FirebaseAuth.instance;
class Myprofile extends StatefulWidget {
  const Myprofile({Key? key});

  @override
  State<Myprofile> createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {
  bool isOverviewSelected = true;
  bool isAboutSelected = false;
  String nama = '';
  String id = '';
  String image = '';
  String status = '';

  @override
  void initState() {
    super.initState();
    getUserUID();
    getUserName();
    getUserInfo();
    getUserstatus();
  }

  void getUserUID() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    setState(() {
      id = uid;
    });
    print(id);
  }

  Future<void> getUserInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      final id = user.uid;

      final docRef = FirebaseFirestore.instance.collection('users').doc(id);

      await docRef.get().then(
        (DocumentSnapshot doc) {
          if (doc.exists) {
            final data = doc.data() as Map<String, dynamic>;
            setState(() {
              image = data['picture'];
            });
          } else {
            // Tangani kasus ketika dokumen tidak ada, jika diperlukan
          }
        },
        onError: (e) => print("Error getting document: $e"),
      );
    }
  }

  void getUserName() {
    final docRef = FirebaseFirestore.instance.collection('users').doc(id);

    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          nama = data['name'];
        });
        // print(data['name']);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  void getUserstatus() {
    final docRef = FirebaseFirestore.instance.collection('users').doc(id);

    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          status = data['status'];
        });
        // print(data['name']);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }
  Future<int> getGamesItemCount() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String userId = user.uid;

        // Ganti 'users' dengan nama koleksi yang sesuai di Firestore
        QuerySnapshot purchaseSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('purchases')
            .get();

        return purchaseSnapshot.docs.length;
      } else {
        // Handle jika user null
        print('Error: User not logged in');
        return 0;
      }
    } catch (e) {
      // Handle kesalahan jika terjadi
      print('Error counting cart items: $e');
      return 0;
    }
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: 500.0, // Sesuaikan lebar card
              height: 450.0, // Sesuaikan tinggi card
              decoration: BoxDecoration(),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50.0, // Sesuaikan ukuran gambar profil
                    backgroundImage: NetworkImage(
                        image), // Ganti dengan path gambar profil Anda
                    backgroundColor: const Color.fromARGB(255, 150, 149, 149),
                    foregroundColor: Colors
                        .transparent, // Ubah foregroundColor menjadi transparent
                  ),
                  SizedBox(height: 20.0), // Spasi antara gambar profil dan nama
                  Text(
                    nama, // Ganti dengan nama Anda
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0, // Sesuaikan ukuran teks nama
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                      height:
                          10.0), // Spasi antara teks nama dan baris berikutnya
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        status, // Ganti dengan level Anda
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight:
                                FontWeight.bold // Sesuaikan ukuran teks level
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 240.0,
              left: (screenWidth - 164) /
                  2, // (Lebar Layar - Lebar Container) / 2
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color.fromARGB(255, 124, 123, 123),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "lib/icons/online.png",
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Online Status',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 319,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Overview',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: isOverviewSelected
                                  ? const Color.fromARGB(255, 255, 255, 255)
                                  : Colors.white,
                            ),
                          ),
                          Container(
                            width: 85,
                            height: 5,
                            color: isOverviewSelected
                                ? Colors.blue
                                : Colors.transparent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 345,
              child: Column(
                children: [
                  Container(
                    width: 380, // Sesuaikan panjang garis putih
                    height: 2, // Sesuaikan tinggi garis putih
                    color: const Color.fromARGB(
                        255, 116, 114, 114), // Warna garis putih
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 0),
      Positioned(
      top: 375,
      child: Column(
        children: [
          FutureBuilder<int>(
            future: getGamesItemCount(),
            builder: (context, snapshot) {
              int itemCount = snapshot.data ?? 0;
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Jika future sedang dalam proses, tampilkan indikator loading atau pesan lain
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Jika terjadi kesalahan saat mendapatkan data, tampilkan pesan kesalahan
                return Text('Error: ${snapshot.error}');
              } else {
                // Jika data berhasil diambil, tampilkan tampilan yang sesuai
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "lib/icons/console.png",
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                    SizedBox(width: 12),
                    Text(
                      itemCount.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Games',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 145, 144, 144),
                      ),
                    ),
                    SizedBox(width: 15),
                    Row(
                      children: [
                        Image.asset(
                          "lib/icons/friends.png",
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                        SizedBox(width: 12),
                        Text(
                          '99',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Friends',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(255, 145, 144, 144),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Image.asset(
                          "lib/icons/friends.png",
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        ),
                        SizedBox(width: 12),
                        Text(
                          '1',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Years with Ubihard',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(255, 145, 144, 144),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    ),
          ],
        ),
        
      ],
    );
  }
}
