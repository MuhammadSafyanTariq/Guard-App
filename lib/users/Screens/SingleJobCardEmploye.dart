import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guard/admin/utils/colors.dart';
import 'package:guard/users/Screens/JobDetails.dart';

class SingleJobCardEmploye extends StatelessWidget {
  final snap;
  const SingleJobCardEmploye({super.key, this.snap});
  void _showJobDetails(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true, // Set to true for a full-height bottom sheet
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8, // Set to 70% of the screen height
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: AdDetailsPage(
                  position: snap['position'],
                  shift: snap['shift'],
                  rate: snap['rate'],
                  rateType: snap['rateType'],
                  venue: snap['venue'],
                  correspondingPerson: snap['correspondingPerson'],
                  jobType: snap['jobType'],
                  benefits: snap['benefits'],
                  description: snap['description'],
                  email: snap['empContactEmail'],
                  address: snap['address'] ?? '',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
            SizedBox(height: 15),
            Text(snap['description']),
            SizedBox(height: 10),
            Text(snap['benefits']),
            SizedBox(height: 10),
            Row(
              children: [
                Text(snap['rate']),
                SizedBox(
                  width: 5,
                ),
                Text(snap['rateType']),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Shift:'),
                SizedBox(
                  width: 5,
                ),
                Text(snap['shift']),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Job Badge:'),
                SizedBox(
                  width: 5,
                ),
                Text(snap['jobBadge']),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    onPressed: () {
                      _showJobDetails(context);
                    },
                    child: Text('See Details'),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
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
                    child: Text(
                      'Apply',
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
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
