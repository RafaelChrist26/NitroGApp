import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Mygames extends StatefulWidget {
  const Mygames({Key? key}) : super(key: key);

  @override
  State<Mygames> createState() => _MygamesState();
}

class _MygamesState extends State<Mygames> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Map<String, dynamic>>> _getUserPurchases() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String userId = user.uid;

        // Retrieve user's purchases from Firestore
        QuerySnapshot purchaseSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('purchases')
            .get();

        // Fetch game details for each purchase
        List<Map<String, dynamic>> purchases = [];
        for (QueryDocumentSnapshot purchaseDoc in purchaseSnapshot.docs) {
          Map<String, dynamic> purchaseData =
              purchaseDoc.data() as Map<String, dynamic>;
          String gameId = purchaseData['gameId'];

          // Retrieve game details using the game ID
          DocumentSnapshot gameSnapshot = await FirebaseFirestore.instance
              .collection('stores')
              .doc(gameId)
              .get();

          // Combine game details with purchase data
          Map<String, dynamic> combinedData = {
            'gameId': gameId,
            'timestamp': purchaseData['timestamp'],
            'gameDetails': gameSnapshot.data(),
          };

          purchases.add(combinedData);
        }

        return purchases;
      } else {
        return [];
      }
    } catch (e) {
      // Handle errors
      print('Error loading user purchases: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
          List<Map<String, dynamic>> purchases = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Adjust the number of columns as needed
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: purchases.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> purchaseData = purchases[index];
              Map<String, dynamic> gameDetails = purchaseData['gameDetails'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            gameDetails['imageUrl'],
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.black.withOpacity(0.5),
                            child: const Text(
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
                ],
              );
            },
          );
        }
      },
    );
  }
}
