import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guard/Employer/Screen/Widgets/SingleJobCard.dart';
import 'package:guard/users/Screens/LoginScreen.dart';
import 'package:guard/users/Screens/SingleJobCardEmploye.dart';

class FilterNationWideScreen extends StatefulWidget {
  final List<String> selectedBadgeTypes;
  final String selectedJobType;
  final String shift;

  FilterNationWideScreen({
    required this.selectedBadgeTypes,
    required this.selectedJobType,
    required this.shift,
  });
  @override
  State<FilterNationWideScreen> createState() => _FilterNationWideScreenState();
}

class _FilterNationWideScreenState extends State<FilterNationWideScreen> {
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
                stream: widget.shift == 'Any'
                    ? FirebaseFirestore.instance
                        .collection('job')
                        .where('jobBadge', whereIn: widget.selectedBadgeTypes)
                        .where('jobType', isEqualTo: widget.selectedJobType)
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('job')
                        .where('jobBadge', whereIn: widget.selectedBadgeTypes)
                        .where('jobType', isEqualTo: widget.selectedJobType)
                        .where('shift', isEqualTo: widget.shift)
                        .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (ConnectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => SingleJobCardEmploye(
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
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:guard/users/Screens/LoginScreen.dart';
// import 'package:guard/users/Screens/SingleJobCardEmploye.dart';

// class FilteredJobsScreen extends StatefulWidget {
//   final List<String> selectedBadgeTypes;
//   final String shift;
//   final String selectedJobType;
//   final double radius;

//   FilteredJobsScreen({
//     required this.selectedBadgeTypes,
//     required this.shift,
//     required this.selectedJobType,
//     required this.radius,
//   });

//   @override
//   State<FilteredJobsScreen> createState() => _FilteredJobsScreenState();
// }

// class _FilteredJobsScreenState extends State<FilteredJobsScreen> {
//   var userData = {};

//   Position? _currentPosition; // Store the user's current position

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation(); // Get the user's current location when the widget initializes
//   }

//   // Function to get the user's current location
//   void _getCurrentLocation() async {
//     try {
//       final Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       setState(() {
//         _currentPosition = position;
//       });
//     } catch (e) {
//       print('Error obtaining location: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double W = MediaQuery.of(context).size.width;
//     double H = MediaQuery.of(context).size.height;

//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Search JOBS"),
//           backgroundColor: Colors.black,
//         ),
//         body: Center(
//           child: Container(
//             padding: EdgeInsets.all(6),
//             constraints: BoxConstraints(
//               minWidth: W * 0.95,
//               maxWidth: W * 0.95,
//               minHeight: H * 0.8,
//               maxHeight: H * 0.8,
//             ),
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.black,
//                 width: 2,
//                 style: BorderStyle.solid,
//               ),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(
//                   (20),
//                 ),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black,
//                   blurRadius: 20,
//                   spreadRadius: 2.0,
//                   offset: Offset(-10, 7),
//                 ),
//               ],
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Colors.white,
//                   Colors.grey,
//                   const Color.fromARGB(255, 124, 123, 123),
//                 ],
//               ),
//             ),
//             child: StreamBuilder(
              // stream: widget.shift == 'Any'
              //     ? FirebaseFirestore.instance
              //         .collection('job')
              //         .where('jobBadge', whereIn: widget.selectedBadgeTypes)
              //         .where('jobType', isEqualTo: widget.selectedJobType)
              //         .snapshots()
              //     : FirebaseFirestore.instance
              //         .collection('job')
              //         .where('jobBadge', whereIn: widget.selectedBadgeTypes)
              //         .where('jobType', isEqualTo: widget.selectedJobType)
              //         .where('shift', isEqualTo: widget.shift)
              //         .snapshots(),
//               builder: (context,
//                   AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//                 // ignore: unrelated_type_equality_checks
//                 if (ConnectionState == ConnectionState.waiting ||
//                     snapshot.data == null ||
//                     _currentPosition == null) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }

//                 final double radiusInDegrees = widget.radius / 111.32;
//                 final double userLat = _currentPosition!.latitude;
//                 final double userLon = _currentPosition!.longitude;
//                 // final double userLat = 32.437873;
//                 // final double userLon = 74.115622;
//                 print('My lat                   $userLat           $userLon');
//                 final double maxLat = userLat + radiusInDegrees;
//                 final double minLat = userLat - radiusInDegrees;
//                 final double maxLon = userLon + radiusInDegrees;
//                 final double minLon = userLon - radiusInDegrees;

//                 return ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     final jobData = snapshot.data!.docs[index].data();
//                     final jobLat = jobData['latitude'];
//                     final jobLon = jobData['longitude'];

//                     if (jobLat <= maxLat &&
//                         jobLat >= minLat &&
//                         jobLon <= maxLon &&
//                         jobLon >= minLon) {
//                       return SingleJobCardEmploye(snap: jobData);
//                     } else {
//                       return SizedBox();
//                     }
//                   },
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
