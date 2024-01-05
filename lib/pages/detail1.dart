import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Mydetail1 extends StatelessWidget {
  final String gameId;

  const Mydetail1({Key? key, required this.gameId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Details'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('stores').doc(gameId).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
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
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Genre: ${gameData['gameGenre']}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Original Price: Rp.${gameData['gameHarga']}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  if (gameData['gameDiskon'] > 0)
                    Text(
                      'Discount: ${gameData['gameDiskon']}%',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey,
                      ),
                    ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Text(
                        "Developer: ",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color.fromARGB(255, 134, 132, 132),
                        ),
                      ),
                      Text(
                        "${gameData['gameDeveloper']}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Text(
                        "Publisher: ",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color.fromRGBO(134, 132, 132, 1),
                        ),
                      ),
                      Text(
                        "${gameData['gamePubliser']}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Text(
                        "Released: ",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color.fromARGB(255, 134, 132, 132),
                        ),
                      ),
                      Text(
                        "${gameData['gameReleased']}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  Text(
                    "${gameData['gameDescription']}",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 254, 254),
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
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
