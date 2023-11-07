import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                    ? const EditGuardForm()
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
    print('here is hte image url:             $imageUrlG');
    // print(isPoliceG);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
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
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  (20),
                ),
              ),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 20,
                    spreadRadius: 2.0,
                    offset: Offset(-10, 7)),
              ],
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.grey,
                  Color.fromARGB(255, 124, 123, 123)
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (type != 'Guard')
                    SizedBox(
                      height: H * 0.05,
                    ),
                  if (type != 'Guard')
                    const Center(
                      child: Text(
                        'My Information', // Replace with user's name
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  if (type != 'Guard')
                    SizedBox(
                      height: H * 0.03,
                    ),
                  SizedBox(
                      height: H * 0.50,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // if (type == 'Guard')
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                  imageUrlG.toString().length < 5
                                      ? emptyAvatarImage
                                      : imageUrlG.toString()),
                              radius: 50,
                            ),
                            SizedBox(height: H * 0.05),
                            SingleTextRow(
                                text1: type == 'Guard'
                                    ? 'Full Name'
                                    : 'Company Name',
                                text2: FullNameg),
                            SizedBox(height: H * 0.01),
                            SingleTextRow(text1: 'Email', text2: emailg),
                            SizedBox(height: H * 0.01),
                            SingleTextRow(text1: 'Phone', text2: phoneg),
                            SizedBox(height: H * 0.01),
                            SingleTextRow(text1: 'Address', text2: addressg),
                            SizedBox(height: H * 0.01),
                            type == 'Guard'
                                ? Column(
                                    children: [
                                      SingleTextRow(
                                          text1: 'Badge Type', text2: badgesg),
                                      SizedBox(height: H * 0.01),
                                      SingleTextRow(
                                          text1: 'Driving licence ',
                                          text2: drivingLicenceg),
                                      SizedBox(height: H * 0.01),
                                      SingleTextRow(
                                          text1: 'Shift', text2: shiftg),
                                      SizedBox(height: H * 0.01),
                                      genderG.toString().length > 1
                                          ? SingleTextRow(
                                              text1: 'Gender',
                                              text2: genderG ?? '')
                                          : const SizedBox(),
                                      genderG.toString().length > 1
                                          ? SizedBox(height: H * 0.01)
                                          : const SizedBox(),
                                      dobg.toString().length > 5
                                          ? SingleTextRow(
                                              text1: 'Date of Birth',
                                              text2: dobg!
                                                  .toString()
                                                  .substring(0, 10))
                                          : const SizedBox(),
                                      dobg.toString().length > 5
                                          ? SizedBox(height: H * 0.01)
                                          : const SizedBox(),
                                      isPoliceG != null
                                          ? SingleTextRow(
                                              text1:
                                                  'Police or Military Experience',
                                              text2: isPoliceG == true
                                                  ? 'Yes'
                                                  : 'No')
                                          : const SizedBox(),
                                      isPoliceG != null
                                          ? SizedBox(height: H * 0.01)
                                          : const SizedBox(),
                                    ],
                                  )
                                : SingleTextRow(
                                    text1: 'Corresponding person',
                                    text2: correspondingPersong),
                          ],
                        ),
                      )),
                  if (type != 'Guard')
                    SizedBox(
                      height: H * 0.03,
                    ),
                  if (type == 'Guard')
                    SizedBox(
                      height: H * 0.05,
                    ),

                  if (type == 'Guard')
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Profile Strength: ${(profilePercentageG * 100).toInt()}',
                          style: const TextStyle(fontSize: 17),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PercentageProgressBar(
                          param1: genderG.toString(),
                          param2: dobg.toString(),
                          param3: isPoliceG.toString(),
                          param4: imageUrlG.toString(),
                        ),
                      ],
                    ),
                  // Spacer(),
                  if (type == 'Guard')
                    SizedBox(
                      height: H * 0.05,
                    ),
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
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      TextButton(
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
                          imageUrlG = '';
                          genderG = '';
                          isPoliceG = false;
                          dobg = '';
                          postalCodeG = '';
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
                            // backgroundColor: Colors.black,
                            // backgroundColor: Colors.white),

                            ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              Text(
                                'Log out',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],
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
            '$text1:',
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        SizedBox(
          width: W * 0.4,
          child: Text(
            text2,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class PercentageProgressBar extends StatelessWidget {
  final String param1;
  final String param2;
  final String param3;
  final String param4;

  const PercentageProgressBar({
    super.key,
    required this.param1,
    required this.param2,
    required this.param3,
    required this.param4,
  });

  double calculatePercentage() {
    int emptyCount = 0;

    if (param1.length < 2) {
      emptyCount++;
    }
    if (param2.length < 5) {
      emptyCount++;
    }
    if (param3.length < 2) {
      emptyCount++;
    }
    if (param4.length < 4) {
      emptyCount++;
    }

    if (emptyCount == 3) {
      return 0.7; // 70%
    } else if (emptyCount == 2) {
      return 0.8; // 80%
    } else if (emptyCount == 1) {
      return 0.9; // 90%
    } else {
      return 1.0; // 100%
    }
  }

  @override
  Widget build(BuildContext context) {
    final double percentage = calculatePercentage();
    profilePercentageG = percentage;
    return SizedBox(
      height: 20,
      child: Stack(
        children: <Widget>[
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          FractionallySizedBox(
            widthFactor: percentage,
            alignment: Alignment.centerLeft,
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Center(
            child: Text(
              '${(percentage * 100).toStringAsFixed(0)}%',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
