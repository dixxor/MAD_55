import 'package:first/add%20post/add_post.dart';
import 'package:first/compo/bottomnavbar.dart';
import 'package:first/pets/pet1.dart';
import 'package:first/pets/pet2.dart';
import 'package:flutter/material.dart';
import 'package:first/home.dart';
import 'package:first/profile.dart';
import 'package:first/search.dart';
// Import the pet1.dart file or replace with the correct file import

void main() {
  runApp(Favorite());
}

class Favorite extends StatelessWidget {
  // Sample data for the favorite cards
  final List<Map<String, dynamic>> favoriteItems = [
    {
      'image': 'assets/1 (2).jpg',
      'name': 'Winky',
      'age': '1 years',
      'location': 'Moratuwa',
      'onTap': (BuildContext context) {
        print('Winky card tapped');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => pet1()));
      },
    },
    {
      'image': 'assets/timmy.jpg',
      'name': 'Timmy',
      'age': '2 years',
      'location': 'kelaniya',
      'onTap': (BuildContext context) {
        print('thimitha card tapped');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => pet2()));
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ),
        body: ListView.builder(
          itemCount: favoriteItems.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => favoriteItems[index]['onTap'](context),
              child: buildRecentCard(
                favoriteItems[index]['image'],
                favoriteItems[index]['name'],
                favoriteItems[index]['age'],
                favoriteItems[index]['location'],
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavbar(
          currentIndex: 1,
          onTap: (int index) {
            switch (index) {
              case 0: // Home pressed
                print('Home pressed');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
                break;
              case 1: // Search pressed
                print('Search pressed');
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Search()));
                break;
              case 2: // Add pressed
                print('Add pressed');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddPostPage()));
                break;
              case 3: // Favorite pressed
                print('Favorite pressed');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Favorite()));
                break;
              case 4: // Account pressed
                print('Account pressed');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
                break;
              default:
                break;
            }
          },
        ),
      ),
    );
  }

  Widget buildRecentCard(
      String imagePath, String name, String age, String location) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 200.0,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Age: $age',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  'Location: $location',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
