import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostDetailsPage extends StatelessWidget {
  final DocumentSnapshot postSnapshot;

  const PostDetailsPage({Key? key, required this.postSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> postData = postSnapshot.data() as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Pet Name: ${postData['petName']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Age: ${postData['age']}'),
            SizedBox(height: 10),
            Text('Gender: ${postData['gender']}'),
            SizedBox(height: 10),
            Text('Category: ${postData['category']}'),
            SizedBox(height: 10),
            Text('Breed: ${postData['breed']}'),
            SizedBox(height: 10),
            Text('Description: ${postData['description']}'),
            SizedBox(height: 20),
            Divider(),
            Text(
              'Owner Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Owner/Shop Name: ${postData['ownerName']}'),
            SizedBox(height: 10),
            Text('Address: ${postData['address']}'),
            SizedBox(height: 10),
            Text('City: ${postData['city']}'),
            SizedBox(height: 10),
            Text('Contact Number: ${postData['contactNumber']}'),
          ],
        ),
      ),
    );
  }
}
