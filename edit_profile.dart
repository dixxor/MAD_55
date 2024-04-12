import 'package:first/add%20post/add_post.dart';
import 'package:first/compo/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first/models/user.dart';
import 'package:first/services/database.dart';
import 'package:first/shared/loading.dart';
import 'package:first/compo/image_upload.dart';
import 'package:first/favorite.dart';
import 'package:first/home.dart';
import 'package:first/profile.dart';
import 'package:first/search.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool loading = false;
  TextEditingController _editNameController = TextEditingController();
  String imageUrl = '';
  String errorText = '';

  @override
  void dispose() {
    _editNameController.dispose();
    super.dispose();
  }

  void updateImageUrl(String newUrl) {
    setState(() {
      imageUrl = newUrl;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              const Text('Press save changes to update your profile picture.'),
          duration: Duration(seconds: 3), // Increased duration
          backgroundColor: Color(0xFF86BF3E),
        ),
      );
      print('new image: $imageUrl');
    });
  }

  Future<void> updateName(String userId, String name, String image) async {
    try {
      if (_editNameController.text.isNotEmpty) {
        setState(() => loading = true);
        bool result =
            await DatabaseService(userId: userId).updateUserName(name, image);
        print('id: $userId, name: $name, url: $imageUrl');

        if (result == false) {
          setState(() {
            errorText = 'Could not update your details.';
            loading = false;
          });
        }
      } else {
        setState(() {
          errorText = 'Please enter your name';
          loading = false;
        });
      }
    } catch (e) {
      print('Error updating name: $e');
      setState(() {
        errorText = 'An error occurred. Please try again later.';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(userId: user.userId).userData,
      builder: (context, AsyncSnapshot<UserData> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Sorry, an error occurred. ${snapshot.error}'),
          );
        }
        if (snapshot.hasData) {
          UserData userData = snapshot.data!;
          _editNameController.text = userData.name;

          return loading
              ? const Loading()
              : Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: const Text('Edit Profile'),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.save),
                        onPressed: () {
                          updateName(
                              user.userId, _editNameController.text, imageUrl);
                        },
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: CircleAvatar(
                            radius: 90,
                            backgroundColor: Colors.white,
                            backgroundImage: imageUrl.isEmpty
                                ? NetworkImage(userData.profilePicUrl)
                                : NetworkImage(imageUrl),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageUpload(
                              type: 'camera',
                              onImageUrlChange: updateImageUrl,
                            ),
                            ImageUpload(
                              type: 'gallery',
                              onImageUrlChange: updateImageUrl,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextField(
                            controller: _editNameController,
                            obscureText: false,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[400]!,
                                ),
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintText: 'Change your name',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: ElevatedButton(
                            onPressed: () {
                              updateName(
                                userData.userId,
                                _editNameController.text.trim(),
                                imageUrl.isEmpty
                                    ? userData.profilePicUrl
                                    : imageUrl,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: const Text(
                              'Save Changes',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        if (errorText.isNotEmpty)
                          Text(
                            errorText,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: BottomNavbar(
                    currentIndex: 1,
                    onTap: (int index) {
                      switch (index) {
                        case 0: // Home pressed
                          print('Home pressed');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                          break;
                        case 1: // Search pressed
                          print('Search pressed');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Search()));
                          break;
                        case 2: // Add pressed
                          print('Add pressed');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddPostPage()));
                          break;
                        case 3: // Favorite pressed
                          print('Favorite pressed');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Favorite()));
                          break;
                        case 4: // Account pressed
                          print('Account pressed');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Profile()));
                          break;
                        default:
                          break;
                      }
                    },
                  ),
                );
        } else {
          return const Loading();
        }
      },
    );
  }
}
