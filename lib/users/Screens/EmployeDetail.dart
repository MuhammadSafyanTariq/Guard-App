import 'package:flutter/material.dart';
import 'package:guard/admin/utils/GlobalVariables.dart';

class EmployeDetailScreen extends StatefulWidget {
  final String FullName;
  final String email;
  final String phone;
  final List<dynamic> BadgeType;
  final String DrivingLicence;
  final String City;
  final String Shift;
  final String? dateOfBirth;
  final String gender;
  final bool police;
  final String? photoUrl;

  EmployeDetailScreen({
    required this.FullName,
    required this.email,
    required this.phone,
    required this.BadgeType,
    required this.DrivingLicence,
    required this.City,
    required this.Shift,
    required this.dateOfBirth,
    required this.gender,
    required this.police,
    required this.photoUrl,
  });

  @override
  _EmployeDetailScreenState createState() => _EmployeDetailScreenState();
}

class _EmployeDetailScreenState extends State<EmployeDetailScreen> {
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
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                        widget.photoUrl.toString().length < 5
                            ? emptyAvatarImage
                            : widget.photoUrl.toString(),
                      ),
                      radius: 50,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        '${widget.FullName} Details',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SingleTextRow2(text1: 'Email', text2: widget.email),
                    SizedBox(
                      height: 15,
                    ),
                    SingleTextRow2(text1: 'Phone', text2: widget.phone),
                    SizedBox(
                      height: 15,
                    ),
                    SingleTextRow2(
                        text1: 'Badge Type',
                        text2: widget.BadgeType.toString().substring(
                            1, (widget.BadgeType.toString().length - 1))),
                    SizedBox(
                      height: 15,
                    ),
                    SingleTextRow2(
                        text1: 'Driving Licence', text2: widget.DrivingLicence),
                    SizedBox(
                      height: 15,
                    ),
                    SingleTextRow2(text1: 'Address', text2: widget.City),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        child: SingleTextRow2(
                      text1: 'Shift',
                      text2: widget.Shift,
                    )),
                    SizedBox(
                      height: 15,
                    ),
                    if (widget.dateOfBirth.toString().length > 5)
                      SingleTextRow2(
                          text1: 'Date of Birth',
                          text2:
                              widget.dateOfBirth.toString().substring(0, 10)),
                    if (widget.gender.toString().length > 5)
                      SizedBox(
                        height: 15,
                      ),
                    if (widget.gender.toString().length > 3)
                      SingleTextRow2(
                          text1: 'Gender', text2: widget.gender.toString()),
                    if (widget.gender.toString().length > 3)
                      SizedBox(
                        height: 15,
                      ),
                    SingleTextRow2(
                        text1: 'Police OR Military\nExperience',
                        text2: widget.police ? 'Yes' : 'No'),
                    SizedBox(
                      height: 15,
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
          child: Text(
            text2, // Replace with user's name
            // overflow: TextOverflow.ellipsis,
            // maxLines: 3,

            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
