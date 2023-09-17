import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;
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
