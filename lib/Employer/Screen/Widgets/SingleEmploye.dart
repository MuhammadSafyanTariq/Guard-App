import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guard/Employer/Screen/EmployeJob.dart';
import 'package:guard/Employer/Screen/Invite/MyJobList.dart';
import 'package:guard/admin/utils/GlobalVariables.dart';
import 'package:guard/chat/chatpage.dart';

class SingleJEmployeCard extends StatelessWidget {
  final snap;
  const SingleJEmployeCard({super.key, this.snap});

  @override
  Widget build(BuildContext context) {
    double H = MediaQuery.of(context).size.height;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${snap['FullName']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Badges:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(snap['BadgeType'].toString()),
            SizedBox(height: 10),
            Text(
              'Licence Type:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(snap['DrivingLicence']),
            SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         // Handle contact action here
            //       },
            //       child: Text('Contact'),
            //     ),
            //     ElevatedButton(
            //       onPressed: () {
            //         // Handle apply action here
            //       },
            //       child: Text('Apply'),
            //     ),
            //   ],
            // ),
            // Text(
            //   'Contact:',
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            // ),
            // SizedBox(height: 10),
            // Text(
            //   snap['email'],
            //   style: TextStyle(fontStyle: FontStyle.italic),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Text(
            //   snap['phone'],
            //   style: TextStyle(fontStyle: FontStyle.italic),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  textStyle: TextStyle(fontSize: 18),
                ),
                onPressed: () async {
                  userIdForInvitation =
                      snap['uid']; // Replace with the actual document ID

                  showDialog(
                    context: context,
                    builder: (context) => SizedBox(
                      height: H / 50,
                      child: AlertDialog(
                        content: SizedBox(height: H / 3, child: MyJobsList()),
                      ),
                    ),
                  );
                },
                child: Text('Invite'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  textStyle: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChatPage(id: snap['uid'], name: 'username'),
                      ));
                },
                child: Text('Chat'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> inviteToJob(String docId, String candidateId) async {
  try {
    // Reference the Firestore collection and document
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    final DocumentReference docRef = usersCollection.doc(docId);

    // Update the candidates list using FieldValue.arrayUnion
    await docRef.update({
      'invitations': FieldValue.arrayUnion([candidateId]),
    });

    print('Candidate invited successfully to job $docId');
  } catch (e) {
    print('Error adding candidate to job: $e');
    throw e;
  }
}
