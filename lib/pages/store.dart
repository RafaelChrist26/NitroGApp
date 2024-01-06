import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tugas_layout/pages/detail1.dart';
import 'discount_product.dart';

class Mystore extends StatefulWidget {
  const Mystore({super.key});

  @override
  State<Mystore> createState() => _MystoreState();
}

class _MystoreState extends State<Mystore> {
  bool isList = true;


  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 8),
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "SPECIAL OFFERS",
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width > 600 ? 24.0 : 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('stores').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final dataStores = snapshot.data!.docs;
      
                  return ListView.builder(
                    itemCount: dataStores.length,
                    itemBuilder: (context, index) {
                      final product = dataStores[index];
      
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Mydetail1(gameId: product.id,);
                              },
                            ),
                          );
                        },
                        child: Ink(
                          color: const Color.fromARGB(0, 136, 129, 129),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(7),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 45, 46, 46),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.network(
                                  product['imageUrl'],
                                  width: MediaQuery.of(context).size.width > 600
                                      ? 180
                                      : 120,
                                  height: 80,
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['gameTitle'],
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(context).size.width >
                                                      600
                                                  ? 18
                                                  : 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Image.network(
                                            product['os'],
                                            color: Colors.white,
                                            width: 22,
                                            height: 22,
                                          ),
                                          const SizedBox(width: 10),
                                          if (product['gameDiskon'] > 0)
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "-${product['gameDiskon']}%",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Rp.${DiscountCount.mathDiscount(product['gameHarga'], product['gameDiskon'])}',
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
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
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            product['gameGenre'],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width >
                                                      600
                                                  ? 16
                                                  : 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
