import 'package:flutter/material.dart';
import '../Forms/JobForm.dart';

class MyJobs extends StatefulWidget {
  const MyJobs({super.key});

  @override
  State<MyJobs> createState() => _MyJobsState();
}

class _MyJobsState extends State<MyJobs> {
  void _showAdCreationMenu(BuildContext context) {
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
                child: JobForm(), // Display Ads page as slide-up menu
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
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(height: H * 0.01),
              Container(
                padding: EdgeInsets.all(6),
                constraints: BoxConstraints(
                  minWidth: W * 0.95,
                  maxWidth: W * 0.95,
                  minHeight: H * 0.07,
                  maxHeight: H * 0.07,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 20,
                      spreadRadius: 2.0,
                      offset: Offset(-10, 7),
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.grey,
                      const Color.fromARGB(255, 124, 123, 123),
                    ],
                  ),
                ),
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle button press
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: Text(
                        'Delete ad',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: () {
                        _showAdCreationMenu(context); // Show bottom sheet
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: Text(
                        'Create Ad',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
