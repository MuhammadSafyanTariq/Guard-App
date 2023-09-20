import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guard/users/Resource/Auth_Methods.dart';
import 'package:guard/users/Screens/LoginScreen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String phone = '';
  String FullName = '';
  String city = '';

  var userData = {};
  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (userSnap.exists) {
        userData = userSnap.data() as Map<String, dynamic>;
        email = userData['email'];
        phone = userData['phone'];
        if (userData['type'] == 'Guard') {
          city = userData['City'];
          FullName = userData['FullName'];
        } else {
          city = userData['address'];
          FullName = userData['CompanyName'];
        }

        //I am getting correct user type here
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  initState() {
    super.initState();
    getData().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            constraints: BoxConstraints(
              minWidth: W * 0.95,
              maxWidth: W * 0.95,
              minHeight: H * 0.8,
              maxHeight: H * 0.8,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  (20),
                ),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 20,
                    spreadRadius: 2.0,
                    offset: Offset(-10, 7)),
              ],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.grey,
                  const Color.fromARGB(255, 124, 123, 123)
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: H / 20, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'My Information', // Replace with user's name
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 50),
                  SingleTextRow(text1: 'Full Name', text2: FullName),
                  SizedBox(height: 10),
                  SingleTextRow(text1: 'Email', text2: email!),
                  SizedBox(height: 10),
                  SingleTextRow(text1: 'Phone', text2: phone!),
                  SizedBox(height: 10),
                  SingleTextRow(text1: 'City', text2: city),
                  SizedBox(height: 10),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      AuthMethods().signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                      // Add logic for editing profile
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Log out',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: H / 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SingleTextRow extends StatelessWidget {
  final String text1;
  final String text2;
  const SingleTextRow({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${text1}:', // Replace with user's name
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          width: W / 2,
          child: Row(
            children: [
              Text(
                text2, // Replace with user's name
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
