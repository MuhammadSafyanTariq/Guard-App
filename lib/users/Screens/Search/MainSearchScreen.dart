import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guard/users/Forms/FilterForm.dart';
import 'package:guard/users/Screens/Search/AllJobs.dart';
import 'package:guard/users/Screens/Search/FilteredJobs.dart';
import 'package:guard/users/Screens/Search/MatchMejobs.dart';

class MainSearchScreen extends StatelessWidget {
  const MainSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Search Jobs'),
      //   backgroundColor: Colors.black,
      // ),
      body: Container(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: W / 2,
              height: H / 17,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllJobsScreen(),
                    ),
                  );
                },
                child: Text('Show All Jobs'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: W / 2,
              height: H / 17,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FilterFormJobs(),
                    ),
                  );
                },
                child: Text('Filter Jobs'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: W / 2,
              height: H / 17,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatchedJobsScreen(),
                    ),
                  );
                },
                child: Text('Jobs Near me'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
