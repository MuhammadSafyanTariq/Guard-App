import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guard/Employer/Screen/Widgets/SingleEmploye.dart';
import 'package:guard/users/Screens/LoginScreen.dart';

class FilteredEmployesScreen extends StatefulWidget {
  final List<String> selectedBadgeTypes;
  final String selectedShiftPreferences;
  final String selectedDrivingLicense;

  FilteredEmployesScreen({
    required this.selectedBadgeTypes,
    required this.selectedShiftPreferences,
    required this.selectedDrivingLicense,
  });
  @override
  State<FilteredEmployesScreen> createState() => _FilteredEmployesScreenState();
}

class _FilteredEmployesScreenState extends State<FilteredEmployesScreen> {
  var userData = {};

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(type);
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search JOBS"),
          backgroundColor: Colors.black,
        ),
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
            child: StreamBuilder(
                stream: widget.selectedShiftPreferences == 'Any'
                    ? FirebaseFirestore.instance
                        .collection('users')
                        .where('type', isEqualTo: 'Guard')
                        .where('DrivingLicence',
                            isEqualTo: widget.selectedDrivingLicense)
                        .where('BadgeType',
                            arrayContainsAny: widget.selectedBadgeTypes)
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('users')
                        .where('type', isEqualTo: 'Guard')
                        .where('DrivingLicence',
                            isEqualTo: widget.selectedDrivingLicense)
                        .where('BadgeType',
                            arrayContainsAny: widget.selectedBadgeTypes)
                        .where(
                        'Shift',
                        whereIn: [widget.selectedShiftPreferences, 'Any'],
                      ).snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (ConnectionState == ConnectionState.waiting ||
                      snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => SingleJEmployeCard(
                      snap: snapshot.data!.docs[index].data(),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
