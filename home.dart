import 'package:first/aboutuspage.dart';
import 'package:first/add%20post/add_post.dart';
import 'package:first/cats.dart';
import 'package:first/compo/bottomnavbar.dart';
import 'package:first/compo/ex.dart';
import 'package:first/dogs.dart';
import 'package:first/favorite.dart';
import 'package:first/profile.dart';
import 'package:first/search.dart';
import 'package:first/settings.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first/compo/postdetails.dart'; // Assuming this is where your PostDetailsPage is defined

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Function to delete a post and navigate back to HomePage
  Future<void> deletePost(String? postId, BuildContext context) async {
    print('Deleting post with ID: $postId');
    try {
      if (postId != null && postId.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .delete();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Post deleted successfully')),
        );

        // Refresh the UI or update the post list after deletion
        setState(() {});

        Navigator.pop(context); // Navigate back to HomePage
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid post ID')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete post: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 254, 254, 254),
        appBar: AppBar(
          title: const Text('PetPalz'),
          backgroundColor:
              Color.fromARGB(208, 209, 209, 209).withOpacity(_animation.value),
          actions: [
            FadeTransition(
              opacity: _animation,
              child: PopupMenuButton(
                icon: const Icon(Icons.menu),
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    child: Text('Settings'),
                    value: 'settings',
                  ),
                  const PopupMenuItem(
                    child: Text('Posts'),
                    value: 'about',
                  ),
                  const PopupMenuItem(
                    child: Text('AboutUs'),
                    value: 'aboutus',
                  ),
                ],
                onSelected: (String value) {
                  switch (value) {
                    case 'settings':
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()),
                      );
                      break;
                    case 'about':
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PostsPage()),
                      );
                      break;
                    case 'aboutus':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutUsPage()));
                      break;
                    default:
                      break;
                  }
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: Offset.zero,
                ).animate(_animation),
                child: Container(
                  margin: const EdgeInsets.all(13.0),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 117, 36, 255),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Welcome to',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/logo1.png'),
                            backgroundColor: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'PetPalz',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'See how you can find new friends who are the match for you',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1.0, 0.0),
                  end: Offset.zero,
                ).animate(_animation),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(151, 255, 255, 255),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCategoryIcon(
                        'assets/dog.png',
                        'Dogs',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DogsPage()),
                          );
                          print('Dogs category pressed');
                        },
                      ),
                      buildCategoryIcon(
                        'assets/cat.png',
                        'Cats',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CatsPage()),
                          );
                          print('Cats category pressed');
                        },
                      ),
                      buildCategoryIcon(
                        'assets/rabbit.png',
                        'Rabbits',
                        () {
                          // Add your onPressed function for Rabbits category
                          print('Rabbits category pressed');
                        },
                      ),
                      buildCategoryIcon(
                        'assets/dove.png',
                        'Birds',
                        () {
                          // Add your onPressed function for Birds category
                          print('Birds category pressed');
                        },
                      ),
                      buildCategoryIcon(
                        'assets/squirell.png',
                        'Squirrel',
                        () {
                          // Add your onPressed function for Squirrel category
                          print('Squirrel category pressed');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  ' Recent Cards',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Replace this with StreamBuilder for Recent Cards
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('posts').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return SizedBox(
                    height: 320, // Adjust the height as needed
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        String postId = snapshot.data!.docs[index].id;
                        return GestureDetector(
                          onTap: () {
                            data['postId'] = postId;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PostDetailsPage(postData: data),
                              ),
                            );
                          },
                          child: buildRecentCard(
                            data['imageUrl'] ??
                                '', // Updated to use imageUrl field
                            data['petName'] ?? 'Pet Name Not Available',
                            data['age'] ?? 'Not specified',
                            data['city'] ?? 'Unknown',
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Add more sections/widgets as desired
            ],
          ),
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

  Widget buildCategoryIcon(
      String icon, String category, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(118, 177, 177, 177),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.asset(icon, width: 30, height: 30),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            category,
            style: const TextStyle(
              color: Colors.deepPurple,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRecentCard(
      String image, String name, String age, String location) {
    return Container(
      width: 220, // Adjust the width as needed
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: image.isNotEmpty
                  ? Image.network(
                      image,
                      width: double.infinity,
                      height: 210,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(Icons.error),
                        );
                      },
                    )
                  : Placeholder(
                      fallbackHeight: 150,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Age: $age',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Location: $location',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
