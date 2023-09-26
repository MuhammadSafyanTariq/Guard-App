import 'package:flutter/material.dart';
import 'package:guard/users/Screens/JobDetails.dart';

class InvitationCard extends StatelessWidget {
  final snap;
  const InvitationCard({super.key, this.snap});

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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdDetailsPage(
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
                            ),
                          ));
                    },
                    child: Text('View Detail'),
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
