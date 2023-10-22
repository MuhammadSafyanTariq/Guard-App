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
String drivingLicenceg = '';
String shiftg = '';
String typeg = '';
String correspondingPersong = '';
String address2g = '';
String emptyAvatarImage =
    'https://firebasestorage.googleapis.com/v0/b/gaurdpass.appspot.com/o/avatar.png?alt=media&token=12e1042c-0504-4ed3-a3d8-c7024088c0ce';
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
        print(shiftg);
      } else {
        addressg = userData['address'];
        FullNameg = userData['CompanyName'];
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
}
