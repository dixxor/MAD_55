import 'package:first/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostDetailsPage extends StatelessWidget {
  final Map<String, dynamic> postData;

  const PostDetailsPage({Key? key, required this.postData}) : super(key: key);

  Future<void> deletePost(String? postId, BuildContext context) async {
    print('Deleting post with ID: $postId');
    try {
      // Check if postId is not null and is a non-empty string
      if (postId != null && postId.isNotEmpty) {
        // Delete the document with the specified postId
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId) // Use postId directly here
            .delete();

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Post deleted successfully')),
        );

        // Navigate back to the home page after deletion
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        ); // Go back to the home page
      } else {
        // postId is null or empty, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid post ID')),
        );
      }
    } catch (e) {
      // Error occurred during deletion, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete post: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Post Data: $postData');
    String postId = postData['postId'] ?? '';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pet Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Delete Post'),
                    content: Text('Are you sure you want to delete this post?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                          deletePost(postId, context);

                          deletePost(postData['postId'], context);
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 350.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(postData['imageUrl'] ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pet Name: ${postData['petName'] ?? 'Not specified'}',
                  style: const TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '(${postData['category'] ?? 'Not specified'})',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Text(
              'Location: ${postData['city'] ?? 'Not specified'}',
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.male,
                        color: Color.fromARGB(188, 98, 0, 255)),
                    const SizedBox(width: 5.0),
                    Text('${postData['gender'] ?? 'Not specified'}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0))),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        color: Color.fromARGB(188, 98, 0, 255)),
                    const SizedBox(width: 5.0),
                    Text('${postData['age'] ?? 'Not specified'}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0))),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.pets,
                        color: Color.fromARGB(188, 98, 0, 255)),
                    const SizedBox(width: 5.0),
                    Text('${postData['breed'] ?? 'Not specified'}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0))),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                color: const Color.fromARGB(141, 0, 150, 135),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Contact Details',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Owner Name: ${postData['ownerName'] ?? 'Not specified'}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        'Address: ${postData['address'] ?? 'Not specified'}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        'City: ${postData['city'] ?? 'Not specified'}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        'Contact Number: ${postData['contactNumber'] ?? 'Not specified'}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              '${postData['description'] ?? 'Not specified'}',
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
