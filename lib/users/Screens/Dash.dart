import 'package:flutter/material.dart';

class Dash extends StatelessWidget {
  final List<Ad> ads = [
    Ad(
      title: 'Security Guard Needed',
      description: 'Looking for a security guard for night shift.',
      contactInfo: 'Contact: John Doe (john@example.com)',
    ),
    Ad(
      title: 'CCTV Operator Position',
      description: 'Hiring a CCTV operator with experience.',
      contactInfo: 'Contact: Jane Smith (jane@example.com)',
    ),
    // Add more ads here...
  ];

  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.all(6),
                      constraints: BoxConstraints(
                      minWidth: W*0.95,
                      maxWidth:  W*0.95,
                      minHeight: H*0.8,
                      maxHeight:  H*0.8,
            
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
                          colors: [Colors.white, Colors.grey, const Color.fromARGB(255, 124, 123, 123)],
                        ),
                      ),
            child: ListView.builder(
              itemCount: ads.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ads[index].title,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(ads[index].description),
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
                          ads[index].contactInfo,
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Ad {
  final String title;
  final String description;
  final String contactInfo;

  Ad({required this.title, required this.description, required this.contactInfo});
}

void main() {
  runApp(MaterialApp(home: Dash()));
}