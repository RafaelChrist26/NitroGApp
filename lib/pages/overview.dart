import 'package:flutter/material.dart';
import 'package:UbiSusah_APP/pages/profil.dart';

class overviewpage extends StatefulWidget {
  const overviewpage({super.key});

  @override
  State<overviewpage> createState() => _overviewpageState();
}

class _overviewpageState extends State<overviewpage> {
  bool isOverviewSelected = true;
  bool isAboutSelected = false;
  @override
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
                    'NotRefrainz', // Ganti dengan nama Anda
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Myprofile()));
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
      ],
    );
  }
}
