import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:UbiSusah_APP/pages/datagame.dart';

class Mydetail1 extends StatefulWidget {
  final Product data;
  const Mydetail1({
    super.key,
    required this.data,
  });

  @override
  State<Mydetail1> createState() => _Mydetail1State();
}

class _Mydetail1State extends State<Mydetail1> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(left: 10, top: 8, right: 10, bottom: 8),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("${widget.data.picture}"),
                    SizedBox(height: 20),
                    Text(
                      widget.data.name!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        decoration: TextDecoration.none, // Menghapus underline
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "Developer ",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 134, 132, 132),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                            decoration:
                                TextDecoration.none, // Menghapus underline
                          ),
                        ),
                        Text(
                          "${widget.data.developer!}",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                            decoration:
                                TextDecoration.none, // Menghapus underline
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.5),
                    Row(
                      children: [
                        Text(
                          "Publisher ",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 134, 132, 132),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                            decoration:
                                TextDecoration.none, // Menghapus underline
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${widget.data.publisher!}",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                            decoration:
                                TextDecoration.none, // Menghapus underline
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.5),
                    Row(
                      children: [
                        Text(
                          "Released ",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 134, 132, 132),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                            decoration:
                                TextDecoration.none, // Menghapus underline
                          ),
                        ),
                        SizedBox(width: 9),
                        Text(
                          "${widget.data.released!}",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                            decoration:
                                TextDecoration.none, // Menghapus underline
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Text(
                      "${widget.data.description!}",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 254, 254),
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Arial',
                        decoration: TextDecoration.none, // Menghapus underline
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ],
    );
    // Ambil data produk dari listProduct(
  }
}
