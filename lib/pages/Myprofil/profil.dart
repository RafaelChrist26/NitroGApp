import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

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
  @override
  void initState() {
    super.initState();
    getUserUID();
    getUserName();
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

  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: 500.0, // Sesuaikan lebar card
              height: 450.0, // Sesuaikan tinggi card
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'lib/icons/feed1_2.png'), // Ganti dengan path gambar latar belakang Anda
                    fit: BoxFit.cover,
                    opacity: 220),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50.0, // Sesuaikan ukuran gambar profil
                    backgroundImage: AssetImage(
                        'lib/icons/zeta.png'), // Ganti dengan path gambar profil Anda
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
                        'Level 999', // Ganti dengan level Anda
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight:
                                FontWeight.bold // Sesuaikan ukuran teks level
                            ),
                      ),
                      SizedBox(width: 20),
                      Image.asset(
                        "lib/icons/coin.png",
                        width: 20, // Atur lebar gambar sesuai kebutuhan Anda
                        height: 20, // Atur tinggi gambar sesuai kebutuhan Anda
                      ),
                      SizedBox(width: 5),
                      Text(
                        '999+', // Ganti dengan level Anda
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
              top: 445,
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
            Positioned(
              top: 290.0, // Sesuaikan posisi vertikal teks "Online"
              left: 102.0,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(20), // Radius sudut kotak
                      border: Border.all(
                        color: const Color.fromARGB(
                            255, 124, 123, 123), // Warna border putih
                        width: 2, // Lebar border
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "lib/icons/online.png",
                          width: 20, // Atur lebar gambar sesuai kebutuhan Anda
                          height:
                              20, // Atur tinggi gambar sesuai kebutuhan Anda
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
                  SizedBox(width: 15),
                  Icon(
                    Icons.create_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 419,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isOverviewSelected = true;
                            isAboutSelected = false;
                          });
                        },
                        child: Column(
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
                      ),
                      SizedBox(width: 70),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isAboutSelected = true;
                            isOverviewSelected = false;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'About',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: isAboutSelected
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : Colors.white,
                              ),
                            ),
                            Container(
                              width: 85,
                              height: 5,
                              color: isAboutSelected
                                  ? Colors.blue
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Positioned(
          top: 419,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Pusatkan teks
                children: [
                  Image.asset(
                    "lib/icons/console.png",
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                  SizedBox(width: 12),
                  Text(
                    '999',
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
                        '18+',
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
                          width:
                              15), // Jarak antara "Friends" dan "Years with Ubihard"
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
