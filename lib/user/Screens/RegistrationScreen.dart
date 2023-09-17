import 'package:flutter/material.dart';
import 'package:guard/user/Farms/EmployerForm.dart';
import 'package:guard/user/Farms/GaurdForm.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Register',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Text(
                  'I am A ',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GuardForm()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Guard',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmployerForm()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Employer',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
