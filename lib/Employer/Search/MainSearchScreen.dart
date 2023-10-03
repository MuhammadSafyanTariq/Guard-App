import 'package:flutter/material.dart';
import 'package:guard/Employer/Forms/FilterForm.dart';
import 'package:guard/Employer/Search/AllEmployers.dart';
import 'package:guard/users/Screens/Search/AllJobs.dart';

class MainSearchScreen extends StatelessWidget {
  const MainSearchScreen({super.key});
  showFilterFom(BuildContext context) {
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
                child: FilterForm(),
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

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Search Jobs'),
      //   backgroundColor: Colors.black,
      // ),
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
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: H / 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Search Employers',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: W / 1.8,
                  height: H / 17,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllEmployesScreen(),
                        ),
                      );
                    },
                    child: Text('Show All Employes'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: W / 1.8,
                  height: H / 17,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      showFilterFom(context);
                    },
                    child: Text('Filter Employes'),
                  ),
                ),
                SizedBox(
                  height: H / 8,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
