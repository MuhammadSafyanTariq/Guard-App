import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guard/Employer/Screen/MainPage2.dart';
import 'package:guard/users/Screens/LoginScreen.dart';
import 'package:guard/users/Screens/MainPage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var userData = {};

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      print(userSnap);

      if (userSnap.exists) {
        userData = userSnap.data() as Map<String, dynamic>;
        type = userData['type'];
        //Here I am getting the right type
        print(
            ';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;$type');
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return type == 'employer' ? MainPage() : MainPage2();
  }
}
