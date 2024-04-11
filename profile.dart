import 'package:first/home.dart';
import 'package:first/pets/pet1.dart';
import 'package:first/pets/pet2.dart';
import 'package:first/pets/pet3.dart';
import 'package:first/pets/pet4.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first/services/database.dart';
import 'package:first/models/user.dart';
import 'package:first/edit_profile.dart';
import 'package:first/settings.dart';
import 'package:first/shared/loading.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Stream<QuerySnapshot> userPostsStream;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserModel>(context, listen: false);
    userPostsStream = DatabaseService(userId: user.userId).getUserPosts();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(userId: user.userId).userData,
      builder: (context, AsyncSnapshot<UserData> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        }

        UserData userData = snapshot.data!;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            title: const Text('Profile'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipOval(
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/avatar.png'),
                        image: NetworkImage(userData.profilePicUrl),
                        width: 120.0,
                        height: 120.0,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 120.0,
                            height: 120.0,
                            color: Colors.grey,
                            child: const Center(child: Icon(Icons.error)),
                          );
                        },
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          userData.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                        ),
                        Text(
                          userData.email,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditProfile()));
                  },
                  child: const Text('Edit Profile'),
                ),
                const SizedBox(height: 10.0),
                const SizedBox(height: 10.0),
                const SizedBox(height: 20.0),
                const Text(
                  'My Posts',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),

                //stream
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildRecentCard(
                            'assets/1 (2).jpg',
                            'Winky',
                            '1 years',
                            'Moratuwa',
                            () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => pet1()));
                              print('Winky card tapped');
                              // Navigate to another page, show a dialog, perform an action, etc.
                            },
                          ),
                          buildRecentCard(
                            'assets/timmy.jpg',
                            'Timitha',
                            '2 years',
                            'Kelaniya',
                            () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => pet2()));
                              print('Timitha card tapped');
                              // Navigate to another page, show a dialog, perform an action, etc.
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildRecentCard(
                            'assets/dog3.jpg',
                            'Tyra',
                            '1 month',
                            'Galle',
                            () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => pet3()));
                              print('Fiona card tapped');
                              // Navigate to another page, show a dialog, perform an action, etc.
                            },
                          ),
                          buildRecentCard(
                            'assets/dog44.jpg',
                            'Ariyapala',
                            '10 years',
                            'padukka',
                            () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => pet4()));
                              print('Sense card tapped');
                              // Navigate to another page, show a dialog, perform an action, etc.
                            },
                          ),
                        ],
                      ),
                      // Add more cards or widgets as desired
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget buildRecentCard(String image, String name, String age, String location,
    VoidCallback onTap) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(19),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Age: $age',
                    style:
                        const TextStyle(color: Color.fromARGB(255, 55, 55, 55)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Location: $location',
                    style:
                        const TextStyle(color: Color.fromARGB(255, 61, 61, 61)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
