import 'package:flutter/material.dart';

class PetPost {
  final String userId;
  final String petname;
  final String petAge;
  final String gender;
  final String category;
  final String ownerName;
  final String address;
  final String city;
  final String contactNumber;
  final String description;
  final String photoUrl;

  PetPost({
    required this.userId,
    required this.petname,
    required this.petAge,
    required this.gender,
    required this.category,
    required this.ownerName,
    required this.address,
    required this.city,
    required this.contactNumber,
    required this.description,
    required this.photoUrl,
  });
}

class PetPostProvider extends ChangeNotifier {
  List<PetPost> _petPosts = [];

  List<PetPost> get petPosts => _petPosts;

  void addPetPost(PetPost petPost) {
    _petPosts.add(petPost);
    notifyListeners();
  }
}
