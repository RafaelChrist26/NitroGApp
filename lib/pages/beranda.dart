import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class berandaku extends StatefulWidget {
  const berandaku({super.key});

  @override
  State<berandaku> createState() => _berandakuState();
}

class _berandakuState extends State<berandaku> {
  int selectedIndex = 0; // Indeks terkait dengan tombol "Like"
  String nama = '';
  String id = '';
  String status = '';
  String image = '';
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Card(
            color: Color.fromARGB(255, 45, 46, 46),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: ListTile(
              leading: CircleAvatar(
                maxRadius: 30,
                backgroundColor: const Color.fromARGB(255, 211, 210, 207),
                backgroundImage: NetworkImage(image),
              ),
              title: RichText(
                text: TextSpan(
                  text: nama,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              subtitle: Row(
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.only(left: 10, top: 8, right: 10, bottom: 8),
            child: Row(
              children: <Widget>[
                Text(
                  "Top News",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20 * MediaQuery.of(context).textScaleFactor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 4 / 3,
              viewportFraction: 0.97,
              initialPage: 0,
              enableInfiniteScroll: false,
            ),
            items: [
              // Card pertama
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width *
                    4 /
                    3, // Maintain 4:3 aspect ratio
                padding: EdgeInsets.only(right: 11.5),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  color: Color.fromARGB(255, 45, 46, 46),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bagian atas (gambar)
                      Container(
                        height: 350.0 * MediaQuery.of(context).size.aspectRatio,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                          color: const Color(0xff111111),
                          image: DecorationImage(
                            image: AssetImage("lib/icons/card1.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Bagian bawah (tulisan)
                      GestureDetector(
                        onTap: () {
                          _launchassassin(); // Panggil fungsi _launchURL ketika card ditekan
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(
                                    "ASSASSIN’S CREED® MIRAGE",
                                    style: TextStyle(
                                      fontSize: 18.0 *
                                          MediaQuery.of(context)
                                              .textScaleFactor,
                                      color: Color.fromARGB(255, 180, 179, 179),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Assassin's Creed Mirage - Available Now",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                // Ikon di bawah teks dengan margin
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.open_in_new,
                                      color: const Color.fromARGB(
                                          255, 202, 201, 201),
                                      size: 20.0,
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
                ),
              ),

              // Card lainnya...
              // Card kedua
              Container(
                padding: EdgeInsets.only(right: 11.5),
                width: 475.0, // Mengatur lebar Container untuk Card pertama
                height: 205.0, // Mengatur tinggi Container untuk Card pertama
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  color: Color.fromARGB(255, 45, 46, 46),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bagian atas (gambar)
                      Container(
                        height: 190.0 * MediaQuery.of(context).textScaleFactor,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                          color: const Color(0xff111111),
                          image: DecorationImage(
                            image: AssetImage("lib/icons/card2.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Bagian bawah (tulisan)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                "Netflix's Captain Laserhawk: A Blood Dragon",
                                style: TextStyle(
                                  fontSize: 16.5 *
                                      MediaQuery.of(context).textScaleFactor,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "Remix is out Now",
                                style: TextStyle(
                                  fontSize: 16.5 *
                                      MediaQuery.of(context).textScaleFactor,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Card ketiga
              Container(
                padding: EdgeInsets.only(right: 11.5),
                width: 475.0, // Mengatur lebar Container untuk Card pertama
                height: 205.0, // Mengatur tinggi Container untuk Card pertama
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  color: Color.fromARGB(255, 45, 46, 46),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bagian atas (gambar)
                      Container(
                        height:
                            190.0, // Tinggi gambar sesuaikan dengan kebutuhan
                        width: 475.0, // Mengisi lebar Card
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                          color: const Color(0xff111111),
                          image: DecorationImage(
                            image: AssetImage("lib/icons/card3.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Bagian bawah (tulisan)
                      GestureDetector(
                        onTap: () {
                          _launchUrl(); // Panggil fungsi _launchURL ketika card ditekan
                        },
                        child: Container(
                          width: 375.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const ListTile(
                                title: Text(
                                  "GRAND THEFT AUTO® VI ",
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    color: Color.fromARGB(255, 180, 179, 179),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "Grand Theft Auto VI - Trailer Available Now",
                                  style: TextStyle(
                                    fontSize: 15.5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Ikon di bawah teks dengan margin
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.open_in_new,
                                    color: Color.fromARGB(255, 202, 201, 201),
                                    size: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Card keempat
              Container(
                padding: EdgeInsets.only(right: 11.5),
                width: 475.0, // Mengatur lebar Container untuk Card pertama
                height: 205.0, // Mengatur tinggi Container untuk Card pertama
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  color: Color.fromARGB(255, 45, 46, 46),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bagian atas (gambar)
                      Container(
                        height:
                            190.0, // Tinggi gambar sesuaikan dengan kebutuhan
                        width: 475.0, // Mengisi lebar Card
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                          color: const Color(0xff111111),
                          image: DecorationImage(
                            image: AssetImage("lib/icons/card4.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Bagian bawah (tulisan)
                      Container(
                        width: 375.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                "Miles Morales and Peter Parker pack an",
                                style: TextStyle(
                                  fontSize: 16.5,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "Emotional punch in 'Marvel's Spider-Man 2'",
                                style: TextStyle(
                                  fontSize: 16.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Ikon di bawah teks dengan margin
                            // Container(
                            //   margin: EdgeInsets.symmetric(horizontal: 10.0),
                            //   child: Align(
                            //     alignment: Alignment
                            //         .centerRight, // Mengatur ikon menjadi rata kanan
                            //     child: Icon(
                            //       Icons.open_in_new,
                            //       color: const Color.fromARGB(255, 202, 201, 201),
                            //       size: 20.0,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Card kelima
              Container(
                padding: EdgeInsets.only(right: 11.5),
                width: 475.0, // Mengatur lebar Container untuk Card pertama
                height: 205.0, // Mengatur tinggi Container untuk Card pertama
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  color: Color.fromARGB(255, 45, 46, 46),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bagian atas (gambar)
                      Container(
                        height:
                            190.0, // Tinggi gambar sesuaikan dengan kebutuhan
                        width: 475.0, // Mengisi lebar Card
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                          color: const Color(0xff111111),
                          image: DecorationImage(
                            image: AssetImage("lib/icons/card5.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Bagian bawah (tulisan)
                      GestureDetector(
                        onTap: () {
                          _launchhogwarts(); // Panggil fungsi _launchURL ketika card ditekan
                        },
                        child: Container(
                          width: 375.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                  "HOGWARTS LEGACY",
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    color: Color.fromARGB(255, 180, 179, 179),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "Hogwarts Legacy - Out now on All Devices",
                                  style: TextStyle(
                                    fontSize: 15.5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Ikon di bawah teks dengan margin
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Align(
                                  alignment: Alignment
                                      .centerRight, // Mengatur ikon menjadi rata kanan
                                  child: Icon(
                                    Icons.open_in_new,
                                    color: const Color.fromARGB(
                                        255, 202, 201, 201),
                                    size: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Card keenam
              Container(
                padding: EdgeInsets.only(right: 11.5),
                width: 475.0, // Mengatur lebar Container untuk Card pertama
                height: 205.0, // Mengatur tinggi Container untuk Card pertama
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  color: Color.fromARGB(255, 45, 46, 46),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bagian atas (gambar)
                      Container(
                        height:
                            190.0, // Tinggi gambar sesuaikan dengan kebutuhan
                        width: 475.0, // Mengisi lebar Card
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                          color: const Color(0xff111111),
                          image: DecorationImage(
                            image: AssetImage("lib/icons/card6.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Bagian bawah (tulisan)
                      Container(
                        width: 375.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                "NitroGApp PC Beta - January Update",
                                style: TextStyle(
                                  fontSize: 16.5,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "",
                                style: TextStyle(
                                  fontSize: 16.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Ikon di bawah teks dengan margin
                            // Container(
                            //   margin: EdgeInsets.symmetric(horizontal: 10.0),
                            //   child: Align(
                            //     alignment: Alignment
                            //         .centerRight, // Mengatur ikon menjadi rata kanan
                            //     child: Icon(
                            //       Icons.open_in_new,
                            //       color: const Color.fromARGB(255, 202, 201, 201),
                            // // //       size: 20.0,
                            // // //     ),
                            // //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Tambahkan lebih banyak Card ke dalam slider sesuai kebutuhan
            ],
          ),

          //friend card
          SizedBox(height: 35),
          Container(
            margin: EdgeInsets.only(left: 16, top: 8, right: 10, bottom: 8),
            child: Row(
              children: <Widget>[
                Text(
                  "Friends",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          CarouselSlider(
            options: CarouselOptions(
              initialPage: 0,
              aspectRatio: 1.3 / 1, // Sesuaikan dengan rasio yang Anda inginkan
              viewportFraction: 1.0, // Ukuran relatif setiap item dalam slider
              enableInfiniteScroll: false, // Nonaktifkan scroll tak terbatas
            ),
            items: [
              // Elemen pertama
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 28, 74, 112),
                                Color.fromARGB(255, 48, 3, 3),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Column(
                            children: [
                              // Gambar di atas
                              Container(
                                decoration: BoxDecoration(),
                                child: Image(
                                  image: AssetImage('lib/icons/radit.png'),
                                  fit: BoxFit.contain,
                                  width:
                                      80, // Sesuaikan ukuran gambar sesuai kebutuhan
                                  height:
                                      100, // Sesuaikan ukuran gambar sesuai kebutuhan
                                ),
                              ),

                              // Konten card (judul di bawah gambar)
                              Container(
                                padding: EdgeInsets.all(9.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Raditya Adi',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 7),
                                    Center(
                                      child: Text(
                                        'Online',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 155, 155, 155),
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ), // Jarak antara judul dan teks
                                    Text(
                                      'Playing All Version Nekopara',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              // Tombol "Chat" menjadi rata tengah
                              // Tombol "Chat" dengan ikon dan ukuran yang lebih kecil
                              // Tombol "Chat" dengan ikon
                              SizedBox(height: 35),
                              Container(
                                alignment: Alignment.center,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: 120,
                                      height:
                                          38), // Atur lebar dan tinggi sesuai kebutuhan
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Tindakan yang ingin Anda lakukan saat tombol "Chat" ditekan
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets
                                            .zero, // Hapus padding bawaan
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                        ),
                                        side: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 107, 107, 107)),
                                        backgroundColor: Colors
                                            .transparent // Atur warna garis tepi
                                        ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.chat_bubble_outline_outlined,
                                            size:
                                                20), // Ikon "chat" dengan ukuran 16
                                        SizedBox(
                                            width:
                                                9.0), // Jarak antara ikon dan teks
                                        Text('Chat',
                                            style: TextStyle(
                                                fontSize:
                                                    15)), // Teks "Chat" dengan ukuran 12
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),

                    //Elemen kedua

                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 28, 74, 112),
                                Color.fromARGB(255, 48, 3, 3),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Column(
                            children: [
                              // Gambar di atas
                              Container(
                                decoration: BoxDecoration(),
                                child: Image(
                                  image: AssetImage('lib/icons/ghozyan.png'),
                                  fit: BoxFit.contain,
                                  width:
                                      80, // Sesuaikan ukuran gambar sesuai kebutuhan
                                  height:
                                      100, // Sesuaikan ukuran gambar sesuai kebutuhan
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(9.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Ghozyan Hilman',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 7),
                                    Center(
                                      child: Text(
                                        'Online',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 155, 155, 155),
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ), // Jarak antara judul dan teks
                                    Center(
                                      child: Text(
                                        'Playing Doujin Desu',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Tombol "Chat" menjadi rata tengah
                              // Tombol "Chat" dengan ikon dan ukuran yang lebih kecil
                              // Tombol "Chat" dengan ikon
                              SizedBox(height: 53),
                              Container(
                                alignment: Alignment.center,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: 120,
                                      height:
                                          38), // Atur lebar dan tinggi sesuai kebutuhan
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Tindakan yang ingin Anda lakukan saat tombol "Chat" ditekan
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets
                                            .zero, // Hapus padding bawaan
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                        ),
                                        side: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 107, 107, 107)),
                                        backgroundColor: Colors
                                            .transparent // Atur warna garis tepi
                                        ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.chat_bubble_outline_outlined,
                                            size:
                                                20), // Ikon "chat" dengan ukuran 16
                                        SizedBox(
                                            width:
                                                9.0), // Jarak antara ikon dan teks
                                        Text('Chat',
                                            style: TextStyle(
                                                fontSize:
                                                    15)), // Teks "Chat" dengan ukuran 12
                                      ],
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
              ),

              // Elemen kedua
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 28, 74, 112),
                                Color.fromARGB(255, 48, 3, 3),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Column(
                            children: [
                              // Gambar di atas
                              Container(
                                decoration: BoxDecoration(),
                                child: Image(
                                  image: AssetImage('lib/icons/hehehe.png'),
                                  fit: BoxFit.contain,
                                  width:
                                      80, // Sesuaikan ukuran gambar sesuai kebutuhan
                                  height:
                                      100, // Sesuaikan ukuran gambar sesuai kebutuhan
                                ),
                              ),

                              // Konten card (judul di bawah gambar)
                              Container(
                                padding: EdgeInsets.all(9.0),
                                child: const Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        'Mantan',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 7),
                                    Center(
                                      child: Text(
                                        'Online',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 155, 155, 155),
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ), // Jarak antara judul dan teks
                                    Text(
                                      'Playing Marvel Spiderman 2',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              // Tombol "Chat" menjadi rata tengah
                              // Tombol "Chat" dengan ikon dan ukuran yang lebih kecil
                              // Tombol "Chat" dengan ikon
                              SizedBox(height: 35),
                              Container(
                                alignment: Alignment.center,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: 120,
                                      height:
                                          38), // Atur lebar dan tinggi sesuai kebutuhan
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Tindakan yang ingin Anda lakukan saat tombol "Chat" ditekan
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets
                                            .zero, // Hapus padding bawaan
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                        ),
                                        side: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 107, 107, 107)),
                                        backgroundColor: Colors
                                            .transparent // Atur warna garis tepi
                                        ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.chat_bubble_outline_outlined,
                                            size:
                                                20), // Ikon "chat" dengan ukuran 16
                                        SizedBox(
                                            width:
                                                9.0), // Jarak antara ikon dan teks
                                        Text('Chat',
                                            style: TextStyle(
                                                fontSize:
                                                    15)), // Teks "Chat" dengan ukuran 12
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),

                    //Elemen kedua
                  ],
                ),
              ),
              Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 28, 74, 112),
                          Color.fromARGB(255, 48, 3, 3),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Gambar di atas
                        Container(
                          decoration: BoxDecoration(),
                          child: Image(
                            image: AssetImage('lib/icons/widdi.png'),
                            fit: BoxFit.contain,
                            width: 80,
                            height: 100,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(9.0),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Widdi Geming',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 34.0,
                              ),
                              Center(
                                child: Text(
                                  'Played Benshin Impact',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 53),
                        Container(
                          alignment: Alignment.center,
                          child: ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                                width: 120,
                                height:
                                    38), // Atur lebar dan tinggi sesuai kebutuhan
                            child: ElevatedButton(
                              onPressed: () {
                                // Tindakan yang ingin Anda lakukan saat tombol "Chat" ditekan
                              },
                              style: ElevatedButton.styleFrom(
                                  padding:
                                      EdgeInsets.zero, // Hapus padding bawaan
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                  side: BorderSide(
                                      width: 2,
                                      color:
                                          Color.fromARGB(255, 107, 107, 107)),
                                  backgroundColor: Colors
                                      .transparent // Atur warna garis tepi
                                  ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.chat_bubble_outline_outlined,
                                      size: 20), // Ikon "chat" dengan ukuran 16
                                  SizedBox(
                                      width: 9.0), // Jarak antara ikon dan teks
                                  Text('Chat',
                                      style: TextStyle(
                                          fontSize:
                                              15)), // Teks "Chat" dengan ukuran 12
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Elemen ketiga

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 28, 74, 112),
                                Color.fromARGB(255, 48, 3, 3),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Column(
                            children: [
                              // Gambar di atas
                              Container(
                                decoration: BoxDecoration(),
                                child: Image(
                                  image: AssetImage('lib/icons/aww.png'),
                                  fit: BoxFit.contain,
                                  width:
                                      80, // Sesuaikan ukuran gambar sesuai kebutuhan
                                  height:
                                      100, // Sesuaikan ukuran gambar sesuai kebutuhan
                                ),
                              ),

                              // Konten card (judul di bawah gambar)
                              Container(
                                padding: EdgeInsets.all(9.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Ucok',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 34.0,
                                    ), // Jarak antara judul dan teks
                                    Text(
                                      'Played Grand Theft Auto VI',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              // Tombol "Chat" menjadi rata tengah
                              // Tombol "Chat" dengan ikon dan ukuran yang lebih kecil
                              // Tombol "Chat" dengan ikon
                              SizedBox(height: 35),
                              Container(
                                alignment: Alignment.center,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: 120,
                                      height:
                                          38), // Atur lebar dan tinggi sesuai kebutuhan
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Tindakan yang ingin Anda lakukan saat tombol "Chat" ditekan
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets
                                            .zero, // Hapus padding bawaan
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                        ),
                                        side: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 107, 107, 107)),
                                        backgroundColor: Colors
                                            .transparent // Atur warna garis tepi
                                        ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.chat_bubble_outline_outlined,
                                            size:
                                                20), // Ikon "chat" dengan ukuran 16
                                        SizedBox(
                                            width:
                                                9.0), // Jarak antara ikon dan teks
                                        Text('Chat',
                                            style: TextStyle(
                                                fontSize:
                                                    15)), // Teks "Chat" dengan ukuran 12
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),

                    //Elemen kedua

                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 28, 74, 112),
                                Color.fromARGB(255, 48, 3, 3),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Column(
                            children: [
                              // Gambar di atas
                              Container(
                                decoration: BoxDecoration(),
                                child: Image(
                                  image: AssetImage('lib/icons/kausu.png'),
                                  fit: BoxFit.contain,
                                  width:
                                      80, // Sesuaikan ukuran gambar sesuai kebutuhan
                                  height:
                                      100, // Sesuaikan ukuran gambar sesuai kebutuhan
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(9.0),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Pala Bapak Kau',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 34.0,
                                    ), // Jarak antara judul dan teks
                                    Text(
                                      "Played Assassin's Creed Mirage",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              // Tombol "Chat" menjadi rata tengah
                              // Tombol "Chat" dengan ikon dan ukuran yang lebih kecil
                              // Tombol "Chat" dengan ikon
                              SizedBox(height: 37),
                              Container(
                                alignment: Alignment.center,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: 120,
                                      height:
                                          38), // Atur lebar dan tinggi sesuai kebutuhan
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Tindakan yang ingin Anda lakukan saat tombol "Chat" ditekan
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets
                                            .zero, // Hapus padding bawaan
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                        ),
                                        side: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 107, 107, 107)),
                                        backgroundColor: Colors
                                            .transparent // Atur warna garis tepi
                                        ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.chat_bubble_outline_outlined,
                                            size:
                                                20), // Ikon "chat" dengan ukuran 16
                                        SizedBox(
                                            width:
                                                7.0), // Jarak antara ikon dan teks
                                        Text('Chat',
                                            style: TextStyle(
                                                fontSize:
                                                    15)), // Teks "Chat" dengan ukuran 12
                                      ],
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
              ),
            ],
          ),
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.only(left: 16, top: 8, right: 10, bottom: 8),
            child: Row(
              children: <Widget>[
                Text(
                  "Feed",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          //FEEDSS

          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 4 / 4.9,
              viewportFraction: 0.97,
              initialPage: 0,
              enableInfiniteScroll: false,
            ),
            items: [
              // feed 1
              Container(
                padding: EdgeInsets.only(right: 5),
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color.fromARGB(255, 43, 44, 44),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Kolom 1: Circle Avatar

                      Container(
                        padding: EdgeInsets.only(top: 12.5),
                        margin: EdgeInsets.symmetric(vertical: 6.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            maxRadius: 30,
                            backgroundColor:
                                const Color.fromARGB(255, 211, 210, 207),
                            backgroundImage: AssetImage("lib/icons/radit.png"),
                          ),
                          title: RichText(
                            text: TextSpan(
                              text: 'Raditya Adi',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    16, // Atur ukuran teks sesuai kebutuhan Anda
                                color: Colors
                                    .white, // Atur warna teks sesuai kebutuhan Anda
                              ),
                            ),
                          ),
                          subtitle: Container(
                            padding: EdgeInsets.only(top: 5),
                            child: const Column(
                              // Mengganti Row dengan Column
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Nekopara Deluxe Edition",
                                      style: TextStyle(
                                        color: Colors
                                            .white, // Atur warna teks subtitle sesuai kebutuhan Anda
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: 7), // Menambahkan jarak antara teks
                                Row(
                                  children: [
                                    SizedBox(
                                        width:
                                            1), // Jarak horizontal tambahan jika diperlukan
                                    Text(
                                      "October 24",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 173, 173,
                                            173), // Atur warna teks subtitle sesuai kebutuhan Anda
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Kolom 2: Informasi
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),

                            Divider(
                              color: Color.fromARGB(255, 5, 4, 4),
                              thickness: 1.0, // Ketebalan garis putih
                              height: 1.0, // Sesuaikan dengan kebutuhan Anda
                            ),
                            SizedBox(height: 30), // Menambahkan jarak vertikal

                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 22.0),
                              child: Center(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "lib/icons/games.png",
                                      color: Colors.white,
                                      width:
                                          20, // Atur lebar gambar sesuai kebutuhan Anda
                                      height:
                                          20, // Atur tinggi gambar sesuai kebutuhan Anda
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Started a new game : ",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Nekopara Deluxe Edition",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Kolom 3: Gambar
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.0),
                          image: DecorationImage(
                            image: AssetImage("lib/icons/feed1.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height:
                            230.0, // Sesuaikan dengan ukuran yang Anda inginkan
                      ),
                      // Kolom 4: Tombol Like
                      Container(
                        margin: EdgeInsets.only(left: 7),
                        child: ElevatedButton(
                          onPressed: () {
                            // Tindakan ketika tombol Like ditekan
                            setState(() {
                              if (selectedIndex == 0) {
                                selectedIndex = 1; // Toggle status "Like"
                              } else {
                                selectedIndex = 0; // Kembalikan status "Like"
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 43, 44, 44),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                selectedIndex == 0
                                    ? Icons.thumb_up_alt_outlined
                                    : Icons.thumb_up,
                                color: selectedIndex == 0
                                    ? Colors.white
                                    : Colors.blue,
                              ),
                              SizedBox(
                                  width:
                                      5), // Menambahkan jarak horizontal antara ikon dan teks
                              Text(
                                "Like",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

//---------------------------------------------------------------------------------------------------------

              // feed 2
              Container(
                padding: EdgeInsets.only(right: 5),
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color.fromARGB(255, 43, 44, 44),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Kolom 1: Circle Avatar

                      Container(
                        padding: EdgeInsets.only(top: 12.5),
                        margin: EdgeInsets.symmetric(vertical: 6.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            maxRadius: 30,
                            backgroundColor:
                                const Color.fromARGB(255, 211, 210, 207),
                            backgroundImage: AssetImage("lib/icons/radit.png"),
                          ),
                          title: RichText(
                            text: TextSpan(
                              text: 'Raditya Adi',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    16, // Atur ukuran teks sesuai kebutuhan Anda
                                color: Colors
                                    .white, // Atur warna teks sesuai kebutuhan Anda
                              ),
                            ),
                          ),
                          subtitle: Container(
                            padding: EdgeInsets.only(top: 5),
                            child: const Column(
                              // Mengganti Row dengan Column
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Nekopara Deluxe Edition",
                                      style: TextStyle(
                                        color: Colors
                                            .white, // Atur warna teks subtitle sesuai kebutuhan Anda
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: 7), // Menambahkan jarak antara teks
                                Row(
                                  children: [
                                    SizedBox(
                                        width:
                                            1), // Jarak horizontal tambahan jika diperlukan
                                    Text(
                                      "October 24",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 173, 173,
                                            173), // Atur warna teks subtitle sesuai kebutuhan Anda
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Kolom 2: Informasi
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),

                            Divider(
                              color: Color.fromARGB(255, 5, 4, 4),
                              thickness: 1.0, // Ketebalan garis putih
                              height: 1.0, // Sesuaikan dengan kebutuhan Anda
                            ),
                            SizedBox(height: 30), // Menambahkan jarak vertikal

                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 22.0),
                              child: Center(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "lib/icons/games.png",
                                      color: Colors.white,
                                      width:
                                          20, // Atur lebar gambar sesuai kebutuhan Anda
                                      height:
                                          20, // Atur tinggi gambar sesuai kebutuhan Anda
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Started a new game : ",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Nekopara Deluxe Edition",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Kolom 3: Gambar
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.0),
                          image: DecorationImage(
                            image: AssetImage("lib/icons/feed1.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height:
                            230.0, // Sesuaikan dengan ukuran yang Anda inginkan
                      ),
                      // Kolom 4: Tombol Like
                      Container(
                        margin: EdgeInsets.only(left: 7),
                        child: ElevatedButton(
                          onPressed: () {
                            // Tindakan ketika tombol Like ditekan
                            setState(() {
                              if (selectedIndex == 0) {
                                selectedIndex = 1; // Toggle status "Like"
                              } else {
                                selectedIndex = 0; // Kembalikan status "Like"
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 43, 44, 44),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                selectedIndex == 0
                                    ? Icons.thumb_up_alt_outlined
                                    : Icons.thumb_up,
                                color: selectedIndex == 0
                                    ? Colors.white
                                    : Colors.blue,
                              ),
                              SizedBox(
                                  width:
                                      5), // Menambahkan jarak horizontal antara ikon dan teks
                              Text(
                                "Like",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //---------------------------------------------------------------------------------------------------------

              // feed 2
              Container(
                padding: EdgeInsets.only(right: 5),
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color.fromARGB(255, 43, 44, 44),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Kolom 1: Circle Avatar

                      Container(
                        padding: EdgeInsets.only(top: 12.5),
                        margin: EdgeInsets.symmetric(vertical: 6.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            maxRadius: 30,
                            backgroundColor:
                                const Color.fromARGB(255, 211, 210, 207),
                            backgroundImage: AssetImage("lib/icons/radit.png"),
                          ),
                          title: RichText(
                            text: TextSpan(
                              text: 'Raditya Adi',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    16, // Atur ukuran teks sesuai kebutuhan Anda
                                color: Colors
                                    .white, // Atur warna teks sesuai kebutuhan Anda
                              ),
                            ),
                          ),
                          subtitle: Container(
                            padding: EdgeInsets.only(top: 5),
                            child: const Column(
                              // Mengganti Row dengan Column
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Nekopara Deluxe Edition",
                                      style: TextStyle(
                                        color: Colors
                                            .white, // Atur warna teks subtitle sesuai kebutuhan Anda
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: 7), // Menambahkan jarak antara teks
                                Row(
                                  children: [
                                    SizedBox(
                                        width:
                                            1), // Jarak horizontal tambahan jika diperlukan
                                    Text(
                                      "October 24",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 173, 173,
                                            173), // Atur warna teks subtitle sesuai kebutuhan Anda
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Kolom 2: Informasi
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),

                            Divider(
                              color: Color.fromARGB(255, 5, 4, 4),
                              thickness: 1.0, // Ketebalan garis putih
                              height: 1.0, // Sesuaikan dengan kebutuhan Anda
                            ),
                            SizedBox(height: 30), // Menambahkan jarak vertikal

                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 22.0),
                              child: Center(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "lib/icons/games.png",
                                      color: Colors.white,
                                      width:
                                          20, // Atur lebar gambar sesuai kebutuhan Anda
                                      height:
                                          20, // Atur tinggi gambar sesuai kebutuhan Anda
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Started a new game : ",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Nekopara Deluxe Edition",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Kolom 3: Gambar
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.0),
                          image: DecorationImage(
                            image: AssetImage("lib/icons/feed1.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height:
                            230.0, // Sesuaikan dengan ukuran yang Anda inginkan
                      ),
                      // Kolom 4: Tombol Like
                      Container(
                        margin: EdgeInsets.only(left: 7),
                        child: ElevatedButton(
                          onPressed: () {
                            // Tindakan ketika tombol Like ditekan
                            setState(() {
                              if (selectedIndex == 0) {
                                selectedIndex = 1; // Toggle status "Like"
                              } else {
                                selectedIndex = 0; // Kembalikan status "Like"
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 43, 44, 44),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                selectedIndex == 0
                                    ? Icons.thumb_up_alt_outlined
                                    : Icons.thumb_up,
                                color: selectedIndex == 0
                                    ? Colors.white
                                    : Colors.blue,
                              ),
                              SizedBox(
                                  width:
                                      5), // Menambahkan jarak horizontal antara ikon dan teks
                              Text(
                                "Like",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}

Future<void> _launchUrl() async {
  final Uri _url = Uri.parse('https://www.rockstargames.com/VI');
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

Future<void> _launchassassin() async {
  final Uri _url =
      Uri.parse('https://www.ubisoft.com/en-us/game/assassins-creed/mirage');
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

Future<void> _launchhogwarts() async {
  final Uri _url = Uri.parse('https://www.hogwartslegacy.com/en-us');
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
