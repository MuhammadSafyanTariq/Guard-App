import 'package:flutter/material.dart';
import 'package:guard/Employer/Resources/Post_Job.dart';
import 'package:guard/Employer/Screen/ApplicantsFilter.dart';
import 'package:guard/Employer/Search/AllEmployers.dart';
import 'package:guard/users/Screens/JobDetails.dart';

class SingleJobCardEmployer extends StatelessWidget {
  final snap;
  const SingleJobCardEmployer({super.key, this.snap});
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
                  address: snap['address'],
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
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;

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
                Expanded(
                  // width: W / 2.9,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      _showJobDetails(context);
                    },
                    child: Text('See Details'),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  // width: W / 2.9,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ApplicantsFilterScreen(jid: snap['jid']),
                          ));
                    },
                    child: Text('View Applicants'),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  JobMethods().deleteJob(snap['jid']);
                },
                child: Text('Delete Job'),
              ),
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
