import 'package:flutter/material.dart';
import 'package:guard/chat/chatpage.dart';

class SingleApplicantCard extends StatelessWidget {
  final snap;
  const SingleApplicantCard({super.key, this.snap});

  @override
  Widget build(BuildContext context) {
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
            Text(
              'Contact:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              snap['email'],
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              snap['phone'],
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 10,
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
