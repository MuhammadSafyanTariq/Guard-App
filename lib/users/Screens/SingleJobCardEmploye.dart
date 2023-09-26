import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guard/admin/utils/colors.dart';

class SingleJobCardEmploye extends StatelessWidget {
  final snap;
  const SingleJobCardEmploye({super.key, this.snap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                snap['title'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(snap['description']),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      String docId =
                          snap['jid']; // Replace with the actual document ID
                      String candidateId = FirebaseAuth.instance.currentUser!
                          .uid; // Replace with the candidate ID

                      try {
                        await addCandidateToJob(docId, candidateId);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Text('Applied Successfuly'),
                          ),
                        );
                      } catch (e) {
                        // Handle any errors here
                      }
                    },
                    child: Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> addCandidateToJob(String docId, String candidateId) async {
  try {
    // Reference the Firestore collection and document
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('job');
    final DocumentReference docRef = usersCollection.doc(docId);

    // Update the candidates list using FieldValue.arrayUnion
    await docRef.update({
      'candidates': FieldValue.arrayUnion([candidateId]),
    });

    print('Candidate added successfully to job $docId');
  } catch (e) {
    print('Error adding candidate to job: $e');
    throw e;
  }
}
