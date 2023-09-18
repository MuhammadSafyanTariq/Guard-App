import 'package:flutter/material.dart';

class SingleJobCard extends StatelessWidget {
  final snap;
  const SingleJobCard({super.key, this.snap});

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
                    // Handle contact action here
                  },
                  child: Text('Contact'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle apply action here
                  },
                  child: Text('Apply'),
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
