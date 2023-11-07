import 'package:flutter/material.dart';
import 'package:guard/Employer/Forms/FilterForm.dart';
import 'package:guard/Employer/Search/AllEmployers.dart';
import 'package:guard/Employer/Search/invitartion_accepted_employes.dart';
import 'package:guard/admin/utils/utils.dart';
import 'package:guard/users/Screens/Search/AllJobs.dart';
import 'package:permission_handler/permission_handler.dart';

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
            padding: EdgeInsets.symmetric(vertical: H * 0.02),
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
                SizedBox(
                  height: H * .1,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: W * 0.40,
                      height: H * 0.05,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          textStyle: TextStyle(fontSize: 14),
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
                      width: W * 0.40,
                      height: H * 0.05,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          textStyle: TextStyle(fontSize: 14),
                        ),
                        onPressed: () async {
                          var status = await Permission.location.request();

                          if (status.isGranted) {
                            showFilterFom(context);
                          } else {
                            showSnackBar(
                                'Please give location permisons', context);
                          }
                        },
                        child: Text('Filter Employes'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: W * 0.40,
                      height: H * 0.05,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          textStyle: TextStyle(fontSize: 14),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InvitationAcceptedScreen(),
                            ),
                          );
                        },
                        child: Text('Invitation Accepted'),
                      ),
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
