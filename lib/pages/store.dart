import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tugas_layout/pages/datagame.dart';

import 'package:tugas_layout/pages/detail1.dart';
import 'discount_product.dart';

void main() {
  for (var product in listProduct) {
    product.calculateDiscount();
    // Lakukan sesuatu dengan hasil diskon, misalnya, mencetaknya
  }
}

class Mystore extends StatefulWidget {
  const Mystore({super.key});

  @override
  State<Mystore> createState() => _MystoreState();
}

class _MystoreState extends State<Mystore> {
  bool isList = true;

  void ChangeView(bool isList) {
    setState(() {
      this.isList = !isList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(height: 15),
        // Container(
        //   margin: EdgeInsets.only(left: 10, top: 8, right: 10, bottom: 8),
        //   child: Align(
        //     alignment: Alignment.topLeft,
        //     child: Text(
        //       "FEATURED & RECOMMENDED",
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontSize: 17,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),
        // ),
        // SizedBox(height: 10),
        // CarouselSlider(
        //   options: CarouselOptions(
        //     aspectRatio: 4.5 / 2.7,
        //     viewportFraction: 0.97,
        //     initialPage: 0,
        //     enableInfiniteScroll: false,
        //   ),
        //   items: [
        //     // Card pertama
        //     // ...
        //   ],
        // ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 10, top: 8, right: 10, bottom: 8),
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Text(
                  "SPECIAL OFFERS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:
                        MediaQuery.of(context).size.width > 600 ? 24.0 : 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                isList
                    ? IconButton(
                        onPressed: () {
                          ChangeView(isList);
                        },
                        icon: Icon(Icons.grid_view_outlined),
                        color: Colors.white,
                      )
                    : IconButton(
                        onPressed: () {
                          ChangeView(isList);
                        },
                        icon: Icon(Icons.list),
                        color: Colors.white,
                      )
              ],
            ),
          ),
        ),
        SizedBox(height: 1),
        Expanded(
          child: isList
              ? MediaQuery.of(context).size.width >= 600
                  ? gridviewcustom2(listProduct: listProduct)
                  : gridviewcustom(listProduct: listProduct)
              : listviewcustom(),
        )
      ],
    );
  }
}

class listviewcustom extends StatelessWidget {
  const listviewcustom({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listProduct.length,
      itemBuilder: (context, index) {
        final product = listProduct[index];

        // Ambil data produk dari listProduct

        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Mydetail1(data: listProduct[index]);
              },
            ));
          },
          child: Ink(
            color: Colors.transparent, // Warna latar belakang efek splash
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 45, 46, 46),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Gambar permainan (di sebelah kiri)
                  Image.asset(
                    product.picture!, // Ganti dengan path gambar permainan Anda
                    width: MediaQuery.of(context).size.width > 600
                        ? 180
                        : 120, // Sesuaikan lebar gambar sesuai kebutuhan
                    height: 80, // Sesuaikan tinggi gambar sesuai kebutuhan
                  ),
                  SizedBox(width: 20), // Jarak antara gambar dan teks

                  // Informasi game (di sebelah kanan gambar)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name!, // Ganti dengan nama game
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width > 600
                              ? 18
                              : 15, // Sesuaikan ukuran font sesuai lebar layar
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            product.os!,
                            color: Colors.white, // Ganti dengan path ikon OS
                            width:
                                22, // Sesuaikan lebar ikon OS sesuai kebutuhan
                            height:
                                22, // Sesuaikan tinggi ikon OS sesuai kebutuhan
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width > 600
                                ? 220
                                : 170, // Sesuaikan lebar sesuai dengan lebar layar
                          ),
                          if (product.diskon! > 0)
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "-",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    product.diskon.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "%",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width > 600
                                ? 10
                                : 20, // Sesuaikan lebar sesuai dengan lebar layar
                          ),
                          if (product.diskon! < 1) SizedBox(width: 51),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align children to the right
                              children: [
                                SizedBox(height: 10.5),
                                if (product.diskon! > 0)
                                  Row(
                                    children: [
                                      Text(
                                        "Rp.",
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 255, 253, 253),
                                          fontSize: 12.5,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationThickness: 3.5,
                                          decorationColor: Colors.blue,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        product.harga.toString(),
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 255, 253, 253),
                                          fontSize: 12.5,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationThickness: 3.5,
                                          decorationColor: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                Row(
                                  children: [
                                    Text(
                                      'Rp.${DiscountCount.mathDiscount(product.harga!, product.diskon!)}',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 253, 253),
                                        fontSize: 15,
                                        decorationThickness: 3.5,
                                        decorationColor: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                      ),
                      Row(
                        children: [
                          Text(product.genre!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: MediaQuery.of(context).size.width >
                                        600
                                    ? 16
                                    : 14, // Sesuaikan ukuran font sesuai lebar layar
                              )),
                          Text(", ",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          Text(product.genre2!,
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          if (product.genre3 != null)
                            Row(
                              children: [
                                Text(", ",
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                                Text(product.genre3.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                      ),
                      // Ganti dengan genre permainan
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class gridviewcustom extends StatelessWidget {
  final List<Product> listProduct; // Properti untuk menyimpan listProduct

  gridviewcustom({Key? key, required this.listProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: listProduct.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4.0, // Spasi vertikal antara elemen grid
        crossAxisSpacing: 4.0, // Spasi horizontal antara elemen grid
      ),
      itemBuilder: (context, index) {
        final product = listProduct[index];
        // Ambil data produk dari listProduct

        return GridTile(
          child: InkWell(
            child: Container(
              padding: EdgeInsets.all(2),
              color: Colors.black,
              child: Card(
                color: Color.fromARGB(255, 45, 46, 46),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(product.picture.toString(),
                        fit: BoxFit.fill, height: 85),
                    // Gambar permainan
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .end, // Align children to the right
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  product.name!, // Ganti dengan nama game
                                  style: TextStyle(
                                    fontSize: 14.2,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                children: [
                                  if (product.diskon! > 0)
                                    Text(
                                      "Offer ends 3 Nov @ 12:00am",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 167, 165, 165),
                                        fontSize: 12.5,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 7),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: [
                                    if (product.diskon! < 1)
                                      Text(
                                        product.genre!,
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 167, 165, 165),
                                          fontSize: 12.5,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align the text to the top within the Row
                              children: [
                                if (product.diskon! > 0)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "-",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            product.diskon.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "%",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                Spacer(),
                                SizedBox(
                                    width: 53), // Add some horizontal spacing
                                if (product.diskon! < 1) SizedBox(width: 61),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment
                                      .end, // Align the text to the left
                                  children: [
                                    if (product.diskon! > 0)
                                      Row(
                                        children: [
                                          Text(
                                            "Rp.",
                                            style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 255, 253, 253),
                                              fontSize: 12.5,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationThickness: 3.5,
                                              decorationColor: Colors.blue,
                                            ),
                                          ),
                                          Text(
                                            product.harga.toString(),
                                            style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 255, 253, 253),
                                              fontSize: 12.5,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationThickness: 3.5,
                                              decorationColor: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    Text(
                                      'Rp.${DiscountCount.mathDiscount(product.harga!, product.diskon!)}',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 253, 253),
                                        fontSize: 15,
                                        decorationThickness: 3.5,
                                        decorationColor: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                // Add some horizontal spacing
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class gridviewcustom2 extends StatelessWidget {
  final List<Product> listProduct; // Properti untuk menyimpan listProduct

  gridviewcustom2({Key? key, required this.listProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: listProduct.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4.0, // Spasi vertikal antara elemen grid
        crossAxisSpacing: 4.0, // Spasi horizontal antara elemen grid
      ),
      itemBuilder: (context, index) {
        final product = listProduct[index];
        // Ambil data produk dari listProduct

        return GridTile(
          child: InkWell(
            child: Container(
              padding: EdgeInsets.all(2),
              color: Colors.black,
              child: Card(
                color: Color.fromARGB(255, 45, 46, 46),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(product.picture.toString(),
                        fit: BoxFit.fill, height: 85),
                    // Gambar permainan
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .end, // Align children to the right
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  product.name!, // Ganti dengan nama game
                                  style: TextStyle(
                                    fontSize: 14.2,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                children: [
                                  if (product.diskon! > 0)
                                    Text(
                                      "Offer ends 3 Nov @ 12:00am",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 167, 165, 165),
                                        fontSize: 12.5,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 7),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: [
                                    if (product.diskon! < 1)
                                      Text(
                                        product.genre!,
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 167, 165, 165),
                                          fontSize: 12.5,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align the text to the top within the Row
                              children: [
                                if (product.diskon! > 0)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "-",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            product.diskon.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "%",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                Spacer(),
                                SizedBox(
                                    width: 53), // Add some horizontal spacing
                                if (product.diskon! < 1) SizedBox(width: 61),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment
                                      .end, // Align the text to the left
                                  children: [
                                    if (product.diskon! > 0)
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Row(
                                            children: [
                                              Text(
                                                "Rp.",
                                                style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 255, 253, 253),
                                                  fontSize: 12.5,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationThickness: 3.5,
                                                  decorationColor: Colors.blue,
                                                ),
                                              ),
                                              Text(
                                                product.harga.toString(),
                                                style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 255, 253, 253),
                                                  fontSize: 12.5,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationThickness: 3.5,
                                                  decorationColor: Colors.blue,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    Text(
                                      'Rp.${DiscountCount.mathDiscount(product.harga!, product.diskon!)}',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 253, 253),
                                        fontSize: 15,
                                        decorationThickness: 3.5,
                                        decorationColor: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                // Add some horizontal spacing
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
