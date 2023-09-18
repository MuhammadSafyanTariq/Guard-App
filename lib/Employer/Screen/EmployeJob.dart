import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guard/Screens/SingleJobCard.dart';

class EmployeeJobs extends StatelessWidget {
  final List<Ad> ads = [
    Ad(
      title: 'Security Guard Needed',
      description: 'Looking for a security guard for night shift.',
      contactInfo: 'Contact: John Doe (john@example.com)',
    ),
    Ad(
      title: 'CCTV Operator Position',
      description: 'Hiring a CCTV operator with experience.',
      contactInfo: 'Contact: Jane Smith (jane@example.com)',
    ),
    // Add more ads here...
  ];

  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.all(6),
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
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('job')
                    .where('eid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (ConnectionState == ConnectionState.waiting ||
                      snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => SingleJobCard(
                      snap: snapshot.data!.docs[index].data(),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class Ad {
  final String title;
  final String description;
  final String contactInfo;

  Ad(
      {required this.title,
      required this.description,
      required this.contactInfo});
}

void main() {
  runApp(MaterialApp(home: EmployeeJobs()));
}
