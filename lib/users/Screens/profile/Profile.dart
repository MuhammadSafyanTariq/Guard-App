import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guard/admin/Farms/EmployerForm.dart';
import 'package:guard/admin/utils/GlobalVariables.dart';
import 'package:guard/users/Resource/Auth_Methods.dart';
import 'package:guard/users/Screens/LoginScreen.dart';
import 'package:guard/users/Screens/profile/EditEmployerForm.dart';
import 'package:guard/users/Screens/profile/EditGaurdForm.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void showEmployerForm(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: userData['type'] == 'Guard'
                    ? EditGuardForm()
                    : EditEmployerForm(),
              ),
            ],
          ),
        );
      },
    );
  }

  editProfile() {
    showEmployerForm(context);
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
                  SizedBox(height: H * 0.05),
                  SingleTextRow(
                      text1: type == 'Guard' ? 'Full Name' : 'Company Name',
                      text2: FullNameg),
                  SizedBox(height: H * 0.02),
                  SingleTextRow(text1: 'Email', text2: emailg!),
                  SizedBox(height: H * 0.02),
                  SingleTextRow(text1: 'Phone', text2: phoneg!),
                  SizedBox(height: H * 0.02),
                  SingleTextRow(text1: 'Address', text2: addressg),
                  SizedBox(height: H * 0.02),
                  type == 'Guard'
                      ? Column(
                          children: [
                            SingleTextRow(text1: 'Badge Type', text2: badgesg),
                            SizedBox(height: H * 0.02),
                            SingleTextRow(
                                text1: 'Driving licence ',
                                text2: drivingLicenceg),
                            SizedBox(height: H * 0.02),
                            SingleTextRow(text1: 'Shift', text2: shiftg),
                          ],
                        )
                      : SingleTextRow(
                          text1: 'Corresponding person',
                          text2: correspondingPersong),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          editProfile();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          emailg = '';
                          phoneg = '';
                          FullNameg = '';
                          addressg = '';
                          badgeTypeg = [];
                          badgesg = '';
                          drivingLicenceg = '';
                          shiftg = '';
                          typeg = '';
                          AuthMethods().signOut();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
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
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
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
        SizedBox(
          width: W * 0.35,
          child: Text(
            '${text1}:',
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        SizedBox(
          width: W * 0.4,
          child: Text(
            text2,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
