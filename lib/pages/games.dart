import 'package:flutter/material.dart';

class Mygames extends StatefulWidget {
  const Mygames({Key? key});

  @override
  State<Mygames> createState() => _MygamesState();
}

class _MygamesState extends State<Mygames> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Row(
              children: [
                // Card 1
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Card(
                      margin: EdgeInsets.all(7),
                      child: Stack(
                        // Gunakan Stack untuk menumpuk widget
                        children: [
                          AspectRatio(
                            aspectRatio: 4 / 6,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "lib/icons/games2.jpg"), // Ganti dengan path gambar Anda
                                  fit: BoxFit
                                      .cover, // Atur properti 'fit' sesuai kebutuhan Anda
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 250, // Sesuaikan posisi vertikal teks
                            left: 5, // Sesuaikan posisi horizontal teks
                            child: Container(
                              padding: EdgeInsets.all(8),
                              color: Colors.black.withOpacity(
                                  0.5), // Warna latar belakang transparan
                              child: Text(
                                "PC",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Card 2
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Card(
                      margin: EdgeInsets.all(7),
                      child: Stack(
                        // Gunakan Stack untuk menumpuk widget
                        children: [
                          AspectRatio(
                            aspectRatio: 4 / 6,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "lib/icons/games3.jpg"), // Ganti dengan path gambar Anda
                                  fit: BoxFit
                                      .cover, // Atur properti 'fit' sesuai kebutuhan Anda
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 250, // Sesuaikan posisi vertikal teks
                            left: 5, // Sesuaikan posisi horizontal teks
                            child: Container(
                              padding: EdgeInsets.all(8),
                              color: Colors.black.withOpacity(
                                  0.5), // Warna latar belakang transparan
                              child: Text(
                                "PC",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    // Card 3
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Card(
                          margin: EdgeInsets.all(7),
                          child: Stack(
                            // Gunakan Stack untuk menumpuk widget
                            children: [
                              AspectRatio(
                                aspectRatio: 4 / 6,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "lib/icons/games_1.jpeg"), // Ganti dengan path gambar Anda
                                      fit: BoxFit
                                          .cover, // Atur properti 'fit' sesuai kebutuhan Anda
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 250, // Sesuaikan posisi vertikal teks
                                left: 5, // Sesuaikan posisi horizontal teks
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  color: Colors.black.withOpacity(
                                      0.5), // Warna latar belakang transparan
                                  child: Text(
                                    "PC",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Card 4
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Card(
                          margin: EdgeInsets.all(7),
                          child: Stack(
                            // Gunakan Stack untuk menumpuk widget
                            children: [
                              AspectRatio(
                                aspectRatio: 4 / 6,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "lib/icons/p.jpg"), // Ganti dengan path gambar Anda
                                      fit: BoxFit
                                          .cover, // Atur properti 'fit' sesuai kebutuhan Anda
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 250, // Sesuaikan posisi vertikal teks
                                left: 5, // Sesuaikan posisi horizontal teks
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  color: Colors.black.withOpacity(
                                      0.5), // Warna latar belakang transparan
                                  child: Text(
                                    "PC",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    // Card 5
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Card(
                          margin: EdgeInsets.all(7),
                          child: Stack(
                            // Gunakan Stack untuk menumpuk widget
                            children: [
                              AspectRatio(
                                aspectRatio: 4 / 6,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "lib/icons/games5.jpeg"), // Ganti dengan path gambar Anda
                                      fit: BoxFit
                                          .cover, // Atur properti 'fit' sesuai kebutuhan Anda
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 250, // Sesuaikan posisi vertikal teks
                                left: 5, // Sesuaikan posisi horizontal teks
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  color: Colors.black.withOpacity(
                                      0.5), // Warna latar belakang transparan
                                  child: Text(
                                    "PC",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Card 6
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Card(
                          margin: EdgeInsets.all(7),
                          child: Stack(
                            // Gunakan Stack untuk menumpuk widget
                            children: [
                              AspectRatio(
                                aspectRatio: 4 / 6,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "lib/icons/games6.jpg"), // Ganti dengan path gambar Anda
                                      fit: BoxFit
                                          .cover, // Atur properti 'fit' sesuai kebutuhan Anda
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 250, // Sesuaikan posisi vertikal teks
                                left: 5, // Sesuaikan posisi horizontal teks
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  color: Colors.black.withOpacity(
                                      0.5), // Warna latar belakang transparan
                                  child: Text(
                                    "PC",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    // Card 5
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Card(
                          margin: EdgeInsets.all(7),
                          child: Stack(
                            // Gunakan Stack untuk menumpuk widget
                            children: [
                              AspectRatio(
                                aspectRatio: 4 / 6,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "lib/icons/games7.jpeg"), // Ganti dengan path gambar Anda
                                      fit: BoxFit
                                          .cover, // Atur properti 'fit' sesuai kebutuhan Anda
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 250, // Sesuaikan posisi vertikal teks
                                left: 5, // Sesuaikan posisi horizontal teks
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  color: Colors.black.withOpacity(
                                      0.5), // Warna latar belakang transparan
                                  child: Text(
                                    "PC",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Card 6
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Card(
                          margin: EdgeInsets.all(7),
                          child: Stack(
                            // Gunakan Stack untuk menumpuk widget
                            children: [
                              AspectRatio(
                                aspectRatio: 4 / 6,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "lib/icons/games8.jpg"), // Ganti dengan path gambar Anda
                                      fit: BoxFit
                                          .cover, // Atur properti 'fit' sesuai kebutuhan Anda
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 250, // Sesuaikan posisi vertikal teks
                                left: 5, // Sesuaikan posisi horizontal teks
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  color: Colors.black.withOpacity(
                                      0.5), // Warna latar belakang transparan
                                  child: Text(
                                    "PC",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ],
    );
  }
}
