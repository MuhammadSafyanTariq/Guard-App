import 'package:flutter/material.dart';
import 'package:guard/users/Screens/Profile.dart';

class AdDetailsPage extends StatefulWidget {
  final String position;
  final String shift;
  final String rate;
  final String rateType;
  final String venue;
  final String correspondingPerson;
  final String jobType;
  final String benefits;
  final String description;
  final String email;

  AdDetailsPage({
    required this.position,
    required this.shift,
    required this.rate,
    required this.rateType,
    required this.venue,
    required this.correspondingPerson,
    required this.jobType,
    required this.benefits,
    required this.description,
    required this.email,
  });

  @override
  _AdDetailsPageState createState() => _AdDetailsPageState();
}

class _AdDetailsPageState extends State<AdDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ad Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleTextRow2(text1: 'Position', text2: widget.position),
            SizedBox(
              height: 15,
            ),
            SingleTextRow2(text1: 'Shift', text2: widget.shift),
            SizedBox(
              height: 15,
            ),
            SingleTextRow2(text1: 'Rate', text2: widget.rateType),
            SizedBox(
              height: 15,
            ),
            SingleTextRow2(text1: 'Job Type', text2: widget.jobType),
            SizedBox(
              height: 15,
            ),
            SingleTextRow2(text1: 'Benefits', text2: widget.benefits),
            SizedBox(
              height: 15,
            ),
            SingleTextRow2(text1: 'Email', text2: widget.email),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Coresponding person:    ', // Replace with user's name
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Text(
                        widget.correspondingPerson, // Replace with user's name
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Venue',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              widget.venue,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Description',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              widget.description,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleTextRow2 extends StatelessWidget {
  final String text1;
  final String text2;
  const SingleTextRow2({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${text1}:', // Replace with user's name
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(
          width: W / 2,
          child: Row(
            children: [
              Text(
                text2, // Replace with user's name
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
