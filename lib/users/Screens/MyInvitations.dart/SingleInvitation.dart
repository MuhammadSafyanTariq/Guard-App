import 'package:flutter/material.dart';
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
            Text(
              snap['description'],
              overflow: TextOverflow.ellipsis,
            ),
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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    onPressed: () {
                      _showJobDetails(context);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => AdDetailsPage(
                      //         position: snap['position'],
                      //         shift: snap['shift'],
                      //         rate: snap['rate'],
                      //         rateType: snap['rateType'],
                      //         venue: snap['venue'],
                      //         correspondingPerson: snap['correspondingPerson'],
                      //         jobType: snap['jobType'],
                      //         benefits: snap['benefits'],
                      //         description: snap['description'],
                      //         email: snap['empContactEmail'],
                      //       ),
                      //     ));
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
