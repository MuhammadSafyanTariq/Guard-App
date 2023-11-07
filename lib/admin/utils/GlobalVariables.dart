import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;
late String jidForInvitaion;
late String userIdForInvitation;
List<Widget> homeScreenItems = [
  // const FeedScreen(),
  // const SearchScreen(),
  // const AddPostScreen(),
  const Center(
    child: Text(
      'Welcome to Bunnygram',
      style: TextStyle(
        fontFamily: 'Billabong',
        fontSize: 35,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  // ProfileScreen(
  //   uid: FirebaseAuth.instance.currentUser!.uid,
  // ),
];

String emailg = '';
String phoneg = '';
String FullNameg = '';
String addressg = '';
List<dynamic> badgeTypeg = [];
String badgesg = '';
int profilePercent = 60;
String drivingLicenceg = '';
String shiftg = '';
String typeg = '';
String correspondingPersong = '';
String address2g = '';
String emptyAvatarImage =
    'https://firebasestorage.googleapis.com/v0/b/gaurdpass.appspot.com/o/avatar.png?alt=media&token=12e1042c-0504-4ed3-a3d8-c7024088c0ce';
String? imageUrlG;
String? genderG;
bool? isPoliceG;
String? dobg;
String? postalCodeG;
double profilePercentageG = 60;
var userData = {};
getData() async {
  try {
    var userSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (userSnap.exists) {
      userData = userSnap.data() as Map<String, dynamic>;
      emailg = userData['email'];
      phoneg = userData['phone'];
      if (userData['type'] == 'Guard') {
        addressg = userData['City'];
        FullNameg = userData['FullName'];
        badgeTypeg = userData['BadgeType'];
        badgesg = badgeTypeg.toString();
        badgesg = badgesg.substring(1, badgesg.length - 1);
        drivingLicenceg = userData['DrivingLicence'];
        shiftg = userData['Shift'];
        print(addressg);
        try {
          imageUrlG = userData['photoUrl'];
          print(imageUrlG);
          // imageUrlG = userData['photoUrl'] ?? userData['imageUrl'];
          print(imageUrlG);
        } catch (e) {}
        try {
          genderG = userData['gender'];
        } catch (e) {}
        try {
          isPoliceG = userData['police'];
        } catch (e) {}
        try {
          dobg = userData['dateOfBirth'];
        } catch (e) {}
        try {
          postalCodeG = userData['postCode'];
        } catch (e) {}
      } else {
        addressg = userData['address'];
        FullNameg = userData['CompanyName'];
        try {
          imageUrlG = userData['photoUrl'];

          print('here is the image;                $imageUrlG');
        } catch (e) {}
        correspondingPersong = userData['CorrespondingPerson'];
        print(
            'ccccccccccccccccccccccccccccccccccccccccccccccccc$correspondingPersong');
      }

      //I am getting correct user type here
    } else {
      print('Document does not exist');
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
  // if (imageUrlG.toString().length > 5&&) {
  //   profilePercent += 20;
  // }
  // if (imageUrlG.toString().length > 5) {
  //   profilePercent += 20;
  // }
  // if (genderG.toString().length > 1) {
  //   profilePercent += 5;
  // }
  // if (dobg.toString().length > 5) {
  //   profilePercent += 10;
  // }

  // if (isPoliceG.toString().length > 1) {
  //   profilePercent += 5;
  // }
}
