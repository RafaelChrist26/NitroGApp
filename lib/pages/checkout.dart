import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tugas_layout/pages/discount_product.dart';

class CheckoutPage extends StatefulWidget {
  final String gameId;

  CheckoutPage({Key? key, required this.gameId}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Map<String, dynamic>>> _getUserPurchases() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String userId = user.uid;

        QuerySnapshot purchaseSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('cart')
            .get();

        List<Map<String, dynamic>> purchases = [];

        for (QueryDocumentSnapshot purchaseDoc in purchaseSnapshot.docs) {
          Map<String, dynamic> cartsData =
              purchaseDoc.data() as Map<String, dynamic>;

          String gameId = cartsData['gameId'];

          DocumentSnapshot gameSnapshot = await FirebaseFirestore.instance
              .collection('stores')
              .doc(gameId)
              .get();

          if (gameSnapshot.exists) {
            Map<String, dynamic>? gameData =
                gameSnapshot.data() as Map<String, dynamic>?;

            if (gameData != null) {
              Map<String, dynamic> combinedData = {
                'gameId': gameId,
                'timestamp': cartsData['timestamp'],
                'gameDetails': gameData,
              };

              purchases.add(combinedData);
            } else {
              print('Data game null: $gameId');
            }
          } else {
            print('Dokumen game tidak ditemukan: $gameId');
          }
        }

        return purchases;
      } else {
        print('User not logged in');
        return [];
      }
    } catch (e) {
      print('Error loading user purchases: $e');
      return [];
    }
  }

  Future<int> _calculateTotalPrice(List<Map<String, dynamic>> purchases) async {
    int total = 0;

    for (var purchase in purchases) {
      var gameDetails = purchase['gameDetails'];
      int discountedPrice = DiscountCount.mathDiscount(
          gameDetails['gameHarga'], gameDetails['gameDiskon']);
      total += discountedPrice;
    }

    return total;
  }

  Future<void> _removeFromCart(String gameId) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Get the reference to the document in the "cart" collection
        DocumentReference cartItemRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('cart')
            .doc(gameId);

        // Check if the document exists before attempting to delete
        DocumentSnapshot cartItemSnapshot = await cartItemRef.get();
        if (cartItemSnapshot.exists) {
          // Delete the document from the "cart" collection
          await cartItemRef.delete();

          print('Item removed from cart successfully!');
        } else {
          print('Item not found in the cart for gameId: $gameId');
        }
      } else {
        print('User not logged in or gameId is null');
      }
    } catch (e) {
      print('Error removing item from cart: $e');
    }
  }

  Future<void> _moveCartToPurchase() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String userId = user.uid;

        // Get the user's cart items
        QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('cart')
            .get();

        // Create a batch for atomic operations
        WriteBatch batch = FirebaseFirestore.instance.batch();

        // Iterate through cart items and move them to the "purchase" collection
        for (QueryDocumentSnapshot cartItemDoc in cartSnapshot.docs) {
          Map<String, dynamic> cartItemData =
              cartItemDoc.data() as Map<String, dynamic>;
          String gameId = cartItemData['gameId'];

          // Add the cart item to the "purchase" collection
          DocumentReference purchaseItemRef = FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('purchases')
              .doc(gameId);

          batch.set(purchaseItemRef, {
            'gameId': gameId,
            'timestamp': cartItemData['purchaseDate'],
          });

          // Delete the cart item
          DocumentReference cartItemRef = FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('cart')
              .doc(cartItemDoc.id);

          batch.delete(cartItemRef);
        }

        // Commit the batch
        await batch.commit();

        print('Cart items moved to purchases successfully!');
        setState(() {});
      } else {
        print('User not logged in');
      }
    } catch (e) {
      print('Error moving cart items to purchases: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 136, 129, 129),
        title: Text(
          'Your Shopping Cart',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
        future: _getUserPurchases(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
              child: Text('Error loading user purchases'),
            );
          } else {
            var purchases = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ...purchases.map((purchase) {
                    var gameData = purchase['gameDetails'];

                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(7),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 45, 46, 46),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network(
                                gameData['imageUrl'],
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.network(
                                          gameData['os'][0],
                                          color: Colors.white,
                                          width: 22,
                                          height: 22,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () async {
                                                print(
                                                    'gameData before removeFromCart: $gameData');
                                                print(
                                                    'Before calling removeFromCart. gameId: ${purchase['gameId']}');

                                                if (purchase['gameId'] !=
                                                    null) {
                                                  await _removeFromCart(
                                                    purchase['gameId'],
                                                  );

                                                  setState(() {});
                                                }

                                                print(
                                                    'gameData after removeFromCart: $gameData');
                                                print(
                                                    'gameId after removeFromCart: ${purchase['gameId']}');
                                              },
                                              child: Text(
                                                'Remove',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                if (gameData['gameDiskon'] < 0)
                                                  Text(
                                                    "Rp. ${gameData['gameHarga']}",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationThickness: 3.0,
                                                      decorationColor:
                                                          Colors.blue,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                SizedBox(
                                                  width: 6.0,
                                                ),
                                                if (gameData['gameDiskon'] > 0)
                                                  Container(
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .end, // Align to the right
                                                      children: [
                                                        Text(
                                                          "-${gameData['gameDiskon']}%",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                SizedBox(width: 12),
                                                Column(
                                                  children: [
                                                    if (gameData['gameDiskon'] >
                                                        0)
                                                      Text(
                                                        'Rp.${gameData['gameHarga']}',
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              253,
                                                              253),
                                                          fontSize: 15,
                                                          decorationThickness:
                                                              6.5,
                                                          decorationColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  9,
                                                                  152,
                                                                  218),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        ),
                                                        textAlign: TextAlign
                                                            .right, // Align to the right
                                                      ),
                                                    Text(
                                                      'Rp.${DiscountCount.mathDiscount(gameData['gameHarga'], gameData['gameDiskon'])}',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 255, 255, 255),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            gameData['gameTitle'],
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width >
                                                      600
                                                  ? 18
                                                  : 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines:
                                                2, // Set the maximum number of lines
                                            overflow: TextOverflow
                                                .ellipsis, // Use ellipsis for overflow
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
                      ],
                    );
                  }).toList(),
                  FutureBuilder(
                    future: _calculateTotalPrice(purchases),
                    builder: (context, AsyncSnapshot<int> totalSnapshot) {
                      if (totalSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (totalSnapshot.hasError ||
                          !totalSnapshot.hasData) {
                        return const Center(
                          child: Text('Error calculating total price'),
                        );
                      } else {
                        int total = totalSnapshot.data!;
                        SizedBox(
                          height: 10.0,
                        );
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(7),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 45, 46, 46),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Estimated Total",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6.0,
                                  ),
                                  Text(
                                    'Rp.$total',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 253, 253),
                                      fontSize: 15,
                                      decorationThickness: 3.5,
                                      decorationColor: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Text(
                                "Is this a purchase for yourself or is it a gift? Select one to continue to checkout.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _moveCartToPurchase();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    child: Container(
                                      width: 285,
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          'Purchase for myself',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              )
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
