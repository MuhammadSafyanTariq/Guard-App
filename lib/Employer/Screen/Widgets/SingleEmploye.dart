import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guard/Employer/Screen/Invite/MyJobList.dart';
import 'package:guard/admin/utils/GlobalVariables.dart';
import 'package:guard/chat/chatpage.dart';
import 'package:guard/users/Screens/EmployeDetail.dart';

class SingleJEmployeCard extends StatelessWidget {
  final snap;
  const SingleJEmployeCard({super.key, this.snap});
  void showEmployeeDetails(BuildContext context) {
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
                  child: EmployeDetailScreen(
                FullName: snap["FullName"],
                email: snap["email"],
                phone: snap["phone"],
                BadgeType: snap["BadgeType"],
                DrivingLicence: snap["DrivingLicence"],
                City: snap["City"],
                Shift: snap["Shift"],
                gender: snap['gender'] ?? '',
                dateOfBirth: snap['dateOfBirth'],
                photoUrl: snap['photoUrl'],
                police: snap['police'] ?? false,
              )),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double H = MediaQuery.of(context).size.height;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${snap['FullName']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Badges:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(snap['BadgeType'].toString()),
            const SizedBox(height: 10),
            const Text(
              'Licence Type:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(snap['DrivingLicence']),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () async {
                  userIdForInvitation =
                      snap['uid']; // Replace with the actual document ID

                  showDialog(
                    context: context,
                    builder: (context) => SizedBox(
                      height: H / 50,
                      child: AlertDialog(
                        content: SizedBox(
                          height: H / 3,
                          child: MyJobsList(),
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('Invite'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChatPage(id: snap['uid'], name: 'username'),
                      ));
                },
                child: const Text('Chat'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleJEmployeCard2 extends StatelessWidget {
  final snap;
  const SingleJEmployeCard2({super.key, this.snap});
  void showEmployeeDetails(BuildContext context) {
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
                  child: EmployeDetailScreen(
                FullName: snap["FullName"],
                email: snap["email"],
                phone: snap["phone"],
                BadgeType: snap["BadgeType"],
                DrivingLicence: snap["DrivingLicence"],
                City: snap["City"],
                Shift: snap["Shift"],
                gender: snap['gender'] ?? '',
                dateOfBirth: snap['dateOfBirth'],
                photoUrl: snap['photoUrl'],
                police: snap['police'] ?? false,
              )),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double H = MediaQuery.of(context).size.height;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${snap['FullName']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Badges:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(snap['BadgeType'].toString()),
            const SizedBox(height: 10),
            const Text(
              'Licence Type:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(snap['DrivingLicence']),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () async {
                  userIdForInvitation =
                      snap['uid']; // Replace with the actual document ID

                  showDialog(
                    context: context,
                    builder: (context) => SizedBox(
                      height: H / 50,
                      child: AlertDialog(
                        content: SizedBox(
                          height: H / 3,
                          child: MyJobsList(),
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('Invite'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      showEmployeeDetails(context);
                    },
                    child: const Text('View Details'),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChatPage(id: snap['uid'], name: 'username'),
                          ));
                    },
                    child: const Text('Chat'),
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
    rethrow;
  }
}

Future<void> accepteInvitation(String docId, String idTOAdd) async {
  try {
    // Reference the Firestore collection and document
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    final DocumentReference docRef = usersCollection.doc(docId);

    // Update the candidates list using FieldValue.arrayUnion
    await docRef.update({
      'accepted': FieldValue.arrayUnion([idTOAdd]),
    });

    print('Candidate invited successfully to job $docId');
  } catch (e) {
    print('Error adding candidate to job: $e');
    rethrow;
  }
}
