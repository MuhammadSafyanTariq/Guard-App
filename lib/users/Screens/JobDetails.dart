import 'package:flutter/material.dart';

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
  final String address;

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
    required this.address,
  });

  @override
  _AdDetailsPageState createState() => _AdDetailsPageState();
}

class _AdDetailsPageState extends State<AdDetailsPage> {
  bool isPanelOpen = false;
  double panelHeight = 80.0; // Minimum height when panel is closed

  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(6),
          constraints: BoxConstraints(
            minWidth: W * 0.95,
            maxWidth: W * 0.95,
            minHeight: H * 0.8,
            maxHeight: H * 0.8,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                (20),
              ),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 20,
                  spreadRadius: 2.0,
                  offset: Offset(-10, 7)),
            ],
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.grey,
                const Color.fromARGB(255, 124, 123, 123)
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        'Job Details',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
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
                    SingleTextRow2(text1: 'Address', text2: widget.address),
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
                              color: Colors.black),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Text(
                                widget
                                    .correspondingPerson, // Replace with user's name
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
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
              ],
            ),
          ),
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
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          width: W / 2,
          child: Row(
            children: [
              Text(
                text2, // Replace with user's name
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
