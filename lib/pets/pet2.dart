import 'package:first/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(pet2());
}

class pet2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PetDetailPage(
        petName: 'Timmy',
        petCategory: 'Dog',
        petLocation: 'Kelaniya',
        petImage: 'assets/timmy.jpg',
        petGender: 'Male',
        petAge: '2 year',
        petBreed: 'Germensheped',
        userName: 'whutto me uba',
        userMobile: '123456789',
        petDescription:
            'Meet Timmy, the bundle of joy waiting for a loving home! Winky is an affectionate and energetic dog who thrives on love and companionship. His favorite activities include going on long walks, playing fetch, and spending quality time with his human friends. With his playful nature and friendly demeanor, Winky is sure to bring endless joy and laughter to any family. If youre ready to open your heart and home to a furry friend, Winky is eagerly waiting to become a part of your life!.',
      ),
    );
  }
}

class PetDetailPage extends StatelessWidget {
  final String petName;
  final String petCategory;
  final String petLocation;
  final String petImage;
  final String petGender;
  final String petAge;
  final String petBreed;
  final String userName;
  final String userMobile;
  final String petDescription;

  // Constructor to receive pet details
  PetDetailPage({
    required this.petName,
    required this.petCategory,
    required this.petLocation,
    required this.petImage,
    required this.petGender,
    required this.petAge,
    required this.petBreed,
    required this.userName,
    required this.userMobile,
    required this.petDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
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
                  image: AssetImage(petImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  petName,
                  style: const TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '($petCategory)',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Text(
              petLocation,
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
                    Text(petGender,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0))),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        color: Color.fromARGB(188, 98, 0, 255)),
                    const SizedBox(width: 5.0),
                    Text(petAge,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0))),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.pets,
                        color: Color.fromARGB(188, 98, 0, 255)),
                    const SizedBox(width: 5.0),
                    Text(petBreed,
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
                        'Name: $userName',
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        'Mobile: $userMobile',
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
              petDescription,
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
