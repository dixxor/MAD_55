import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  List<XFile> petImages = []; // List to store pet images

  String selectedCategory = '';
  String petName = '';
  String gender = '';
  String breed = '';
  String age = '';
  String description = '';

  String ownerName = '';
  String address = '';
  String city = '';
  String contactNumber = '';

  final List<String> genders = ['Male', 'Female'];
  final List<String> categories = [
    'Dog',
    'Cat',
    'Rabbit',
    'Squirrel',
    'Bird',
    'Other'
  ];
  Map<String, List<String>> breedsMap = {
    'Dog': ['German Shepherd', 'Doberman', 'None'],
    'Cat': ['Persian', 'None'],
    'Rabbit': ['Rabbit'],
    'Squirrel': ['Squirrel'],
    'Bird': ['Bird'],
    'Other': ['Animal']
  };

  final ImagePicker _picker = ImagePicker();
  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  Future<void> _getImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      // Upload image to Firebase Storage
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('post_images/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageRef.putFile(File(pickedFile.path));

      // Get download URL and add it to Firestore
      uploadTask.then((TaskSnapshot snapshot) async {
        String downloadURL = await snapshot.ref.getDownloadURL();

        // Add the downloadURL to your list of petImages or use it as needed
        setState(() {
          petImages.add(pickedFile);
          // You can use downloadURL here or pass it to a method to add it to Firestore along with other post details
        });
      }).catchError((error) {
        print('Error uploading image: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add Pet Images',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            buildImageCards(),
            const SizedBox(height: 20),
            const Text(
              'Pet Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            buildTextInputField('Pet Name', onChanged: (value) {
              setState(() {
                petName = value;
              });
            }),
            const SizedBox(height: 10),
            buildTextInputField('Age', onChanged: (value) {
              setState(() {
                age = value;
              });
            }),
            const SizedBox(height: 10),
            buildDropdownField('Gender', genders, (String? value) {
              setState(() {
                gender = value ?? '';
              });
            }),
            const SizedBox(height: 10),
            buildDropdownField('Category', categories, (String? value) {
              setState(() {
                selectedCategory = value ?? '';
                breed = ''; // Reset breed when category changes
              });
            }),
            const SizedBox(height: 10),
            if (selectedCategory.isNotEmpty && selectedCategory != 'Other')
              buildDropdownField('Breed', breedsMap[selectedCategory]!,
                  (String? value) {
                setState(() {
                  breed = value ?? '';
                });
              }),
            const SizedBox(height: 10),
            buildTextInputField('Description', maxLines: 3, onChanged: (value) {
              setState(() {
                description = value;
              });
            }),
            const SizedBox(height: 20),
            const Divider(), // Divider between Pet Details and Owner Details
            const Text(
              'Owner Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            buildTextInputField('Owner/Shop Name', onChanged: (value) {
              setState(() {
                ownerName = value;
              });
            }),
            const SizedBox(height: 10),
            buildTextInputField('Address', onChanged: (value) {
              setState(() {
                address = value;
              });
            }),
            const SizedBox(height: 10),
            buildTextInputField('City', onChanged: (value) {
              setState(() {
                city = value;
              });
            }),
            const SizedBox(height: 10),
            buildTextInputField('Contact Number', onChanged: (value) {
              setState(() {
                contactNumber = value;
              });
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (validateData()) {
                  try {
                    await addPostUsingModel();
                    // Reset form after adding the post
                    setState(() {
                      petImages.clear();
                      selectedCategory = '';
                      petName = '';
                      gender = '';
                      breed = '';
                      age = '';
                      description = '';
                      ownerName = '';
                      address = '';
                      city = '';
                      contactNumber = '';
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Post added successfully!'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Color.fromARGB(255, 105, 0, 241),
                    ));
                    // Navigate to home page after success
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Error adding post. Please try again later.'),
                    ));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please fill in all required fields.'),
                  ));
                }
              },
              child: const Text('Add Post'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addPostUsingModel() async {
    try {
      String imageUrl = ''; // Initialize imageUrl
      if (petImages.isNotEmpty) {
        Reference storageRef = FirebaseStorage.instance
            .ref()
            .child('post_images/${DateTime.now().millisecondsSinceEpoch}');
        UploadTask uploadTask = storageRef.putFile(File(petImages[0].path));
        TaskSnapshot snapshot = await uploadTask;
        imageUrl = await snapshot.ref.getDownloadURL();
      }

      await postsCollection.add({
        'petName': petName,
        'age': age,
        'gender': gender,
        'category': selectedCategory,
        'breed': breed,
        'description': description,
        'ownerName': ownerName,
        'address': address,
        'city': city,
        'contactNumber': contactNumber,
        'imageUrl': imageUrl, // Add imageUrl to Firestore
      });
    } catch (e) {
      print('Error adding post: $e');
      throw e;
    }
  }

  bool validateData() {
    return petImages.length >= 2 &&
        petName.isNotEmpty &&
        age.isNotEmpty &&
        gender.isNotEmpty &&
        selectedCategory.isNotEmpty &&
        description.isNotEmpty &&
        ownerName.isNotEmpty &&
        address.isNotEmpty &&
        city.isNotEmpty &&
        contactNumber.isNotEmpty &&
        (selectedCategory == 'Other' || breed.isNotEmpty);
  }

  Widget buildImageCards() {
    return Row(
      children: [
        for (int i = 0; i < petImages.length; i++)
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Handle image preview or deletion if needed
              },
              child: Card(
                elevation: 3,
                margin: const EdgeInsets.all(8),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image(
                    image: FileImage(File(petImages[i].path)),
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      print(
                          'Error loading image: $exception\nStack trace: $stackTrace');
                      return const Text('Error loading image');
                    },
                  ),
                ),
              ),
            ),
          ),
        if (petImages.length < 2)
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Open gallery or camera when clicked
                _showImagePicker(context);
              },
              child: const Card(
                elevation: 3,
                margin: EdgeInsets.all(8),
                child: Icon(Icons.add, size: 40),
              ),
            ),
          ),
      ],
    );
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a picture'),
                onTap: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildTextInputField(String label,
      {int maxLines = 1, required void Function(String) onChanged}) {
    return TextFormField(
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget buildDropdownField(
      String label, List<String> items, void Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: items.isNotEmpty ? items.first : null,
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
