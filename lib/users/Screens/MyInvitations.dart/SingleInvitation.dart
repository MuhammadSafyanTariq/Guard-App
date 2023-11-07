import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guard/Employer/Screen/Widgets/SingleEmploye.dart';
import 'package:guard/users/Screens/JobDetails.dart';

class InvitationCard extends StatelessWidget {
  final snap;
  const InvitationCard({super.key, this.snap});
  void _showJobDetails(BuildContext context) {
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
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                snap['title'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              snap['description'],
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Text(snap['benefits']),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(snap['rate']),
                const SizedBox(
                  width: 5,
                ),
                Text(snap['rateType']),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Shift:'),
                const SizedBox(
                  width: 5,
                ),
                Text(snap['shift']),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Job Badge:'),
                const SizedBox(
                  width: 5,
                ),
                Text(snap['jobBadge']),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    onPressed: () {
                      _showJobDetails(context);
                    },
                    child: const Text('View Detail'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    onPressed: () async {
                      accepteInvitation(
                        FirebaseAuth.instance.currentUser!.uid,
                        snap['eid'],
                      );
                    },
                    child: const Text('Accept'),
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
