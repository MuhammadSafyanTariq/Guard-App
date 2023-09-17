import 'package:flutter/material.dart';

class AdDetailsPage extends StatefulWidget {
  final String position;
  final String location;
  final String shift;
  final String rate;
  final String rateType;
  final String venue;
  final String correspondingPerson;
  final String jobType;
  final String benefits;
  final String description;

  AdDetailsPage({
    required this.position,
    required this.location,
    required this.shift,
    required this.rate,
    required this.rateType,
    required this.venue,
    required this.correspondingPerson,
    required this.jobType,
    required this.benefits,
    required this.description,
  });

  @override
  _AdDetailsPageState createState() => _AdDetailsPageState();
}

class _AdDetailsPageState extends State<AdDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ad Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Position: ${widget.position}'),
            Text('Location: ${widget.location}'),
            Text('Shift: ${widget.shift}'),
            Text('Rate: ${widget.rate} ${widget.rateType}'),
            Text('Venue: ${widget.venue}'),
            Text('Corresponding Person: ${widget.correspondingPerson}'),
            Text('Job Type: ${widget.jobType}'),
            Text('Benefits: ${widget.benefits}'),
            Text('Description: ${widget.description}'),
          ],
        ),
      ),
    );
  }
}