import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('images').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return Text('No images available.');
        }

        var imageDocuments = snapshot.data!.docs;
        List<Widget> imageWidgets = [];

        for (var image in imageDocuments) {
          // Check if the 'url' field exists in the document
          if (image.data()!.containsKey('url')) {
            var imageUrl = image['url'];
            var imageWidget = Image.network(imageUrl);
            imageWidgets.add(imageWidget);
          } else {
            print('Warning: The document does not contain a "url" field.');
          }
        }

        return ListView(
          children: imageWidgets,
        );
      },
    );
  }
}