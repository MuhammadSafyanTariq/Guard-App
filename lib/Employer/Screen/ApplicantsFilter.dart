import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guard/Employer/Screen/Widgets/SingleApplicant.dart';
import 'package:guard/users/Screens/LoginScreen.dart';

class ApplicantsFilterScreen extends StatefulWidget {
  final String jid;

  ApplicantsFilterScreen({super.key, required this.jid});
  @override
  State<ApplicantsFilterScreen> createState() => _ApplicantsFilterScreenState();
}

class _ApplicantsFilterScreenState extends State<ApplicantsFilterScreen> {
  var userData = {};
  List<dynamic> candidates = [];

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('job')
          .doc(widget.jid)
          .get();

      if (userSnap.exists) {
        userData = userSnap.data() as Map<String, dynamic>;
        candidates = userData['candidates'];
        //I am getting correct user type here
        print('User type: $candidates');
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  initState() {
    super.initState();
    getData().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print(type);
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Applicants for this job"),
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
            child: candidates.isNotEmpty
                ? StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('type', isEqualTo: 'Guard')
                        .where('uid', whereIn: candidates)
                        .snapshots(),
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
                        itemBuilder: (context, index) => SingleApplicantCard(
                          snap: snapshot.data!.docs[index].data(),
                        ),
                      );
                    })
                : SizedBox(),
          ),
        ),
      ),
    );
  }
}
