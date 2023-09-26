import 'package:flutter/material.dart';

import 'package:guard/Employer/Resources/Post_Job.dart';
import 'package:guard/Employer/Screen/ApplicantsFilter.dart';
import 'package:guard/Employer/Screen/Widgets/SingleEmploye.dart';
import 'package:guard/Employer/Search/AllEmployers.dart';
import 'package:guard/admin/utils/GlobalVariables.dart';
import 'package:guard/users/Screens/JobDetails.dart';

class SingleJobItem extends StatelessWidget {
  final snap;
  const SingleJobItem({
    Key? key,
    this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        jidForInvitaion = snap['jid'];
        try {
          await inviteToJob(userIdForInvitation, jidForInvitaion);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text('Invited Successfuly'),
            ),
          );
        } catch (e) {
          // Handle any errors here
        }
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              snap['title'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            //
          ],
        ),
      ),
    );
    ;
  }
}
