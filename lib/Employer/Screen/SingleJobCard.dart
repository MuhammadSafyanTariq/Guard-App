import 'package:flutter/material.dart';
import 'package:guard/Employer/Resources/Post_Job.dart';
import 'package:guard/users/Screens/JobDetails.dart';

class SingleJobCardEmployer extends StatelessWidget {
  final snap;
  const SingleJobCardEmployer({super.key, this.snap});

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
            Text(
              snap['title'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(snap['description']),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
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
                      ),
                    );
                  },
                  child: Text('See Details'),
                ),
                ElevatedButton(
                  onPressed: () {
                    JobMethods().deleteJob(snap['jid']);
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              snap['empContactEmail'],
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
