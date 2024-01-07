import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tugas_layout/pages/checkout.dart';
import 'package:tugas_layout/pages/discount_product.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Mydetail1 extends StatelessWidget {
  final String gameId;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Mydetail1({Key? key, required this.gameId}) : super(key: key);

  Future<void> _addToCart(String gameId) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Get the current user's ID
        String userId = user.uid;

        // Add a new document to the user's "cart" collection with gameId as the document ID
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('cart')
            .doc(gameId) // Use gameId as the document ID
            .set({
          'gameId': gameId,
          'purchaseDate': FieldValue.serverTimestamp(),
          // Add other relevant data
        });

        // You can also show a success message or navigate to a success screen
        print('Item added to cart successfully!');
      } else {
        // Handle the case when the user is not logged in
        print('User not logged in');
      }
    } catch (e) {
      // Handle errors
      print('Error adding item to cart: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Game Details'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('stores')
              .doc(gameId)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data == null) {
              return const Center(
                child: Text('Error loading game details'),
              );
            } else {
              var gameData = snapshot.data!;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      gameData['imageUrl'],
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      gameData['gameTitle'],
                      style: const TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Aclonica',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        const Text(
                          "Developer ",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color.fromARGB(255, 134, 132, 132),
                            fontFamily: 'Aclonica',
                          ),
                        ),
                        Text(
                          " ${gameData['gameDeveloper']}",
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Aclonica',
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Text(
                          "Publisher ",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Aclonica',
                            color: Color.fromARGB(255, 134, 132, 132),
                          ),
                        ),
                        Text(
                          " ${gameData['gamePubliser']}",
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue,
                            fontFamily: 'Aclonica',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Text(
                          "Released ",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Aclonica',
                            color: Color.fromARGB(255, 134, 132, 132),
                          ),
                        ),
                        Text(
                          " ${gameData['gameReleased']}",
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Aclonica',
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      "${gameData['gameDescription']}",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 254, 254),
                        fontSize: 16.0,
                        fontFamily: 'Aclonica',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      'GENRE',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Aclonica',
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '${gameData['gameGenre']}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Aclonica',
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 5, 38, 66),
                              Color.fromARGB(255, 71, 2, 110),
                              Color.fromARGB(255, 0, 0, 0),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Buy ${gameData['gameTitle']}',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (gameData['gameDiskon'] < 0)
                                  Text(
                                    'Rp.${gameData['gameHarga']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                    ),
                                  ),
                                SizedBox(
                                    width:
                                        8), // Add spacing between the price and the blue container
                                if (gameData['gameDiskon'] < 0)
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .end, // Align to the right
                                      children: [
                                        Text(
                                          "-${gameData['gameDiskon']}%",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                SizedBox(
                                    width:
                                        12), // Add spacing between the blue container and the next row
                                Column(
                                  children: [
                                    if (gameData['gameDiskon'] > 0)
                                      Text(
                                        'Rp.${gameData['gameHarga']}',
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 253, 253),
                                          fontSize: 15,
                                          decorationThickness: 6.5,
                                          decorationColor:
                                              Color.fromARGB(255, 9, 152, 218),
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                        textAlign: TextAlign
                                            .right, // Align to the right
                                      ),
                                    Text(
                                      'Rp.${DiscountCount.mathDiscount(gameData['gameHarga'], gameData['gameDiskon'])}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    width:
                                        8), // Add spacing between the column and the "Add to Cart" button
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CheckoutPage(
                                                gameId: gameId,
                                              )),
                                    );
                                    _addToCart(gameId);
                                  },
                                  child: Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
