import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guard/Employer/Screen/Widgets/SingleEmploye.dart';
import 'package:guard/users/Screens/LoginScreen.dart';

class InvitationAcceptedScreen extends StatefulWidget {
  const InvitationAcceptedScreen({super.key});

  @override
  State<InvitationAcceptedScreen> createState() =>
      _InvitationAcceptedScreenState();
}

class _InvitationAcceptedScreenState extends State<InvitationAcceptedScreen> {
  var userData = {};

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      print(userSnap);

      if (userSnap.exists) {
        userData = userSnap.data() as Map<String, dynamic>;
        type = userData['type'];
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
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Employes"),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(6),
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
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  (20),
                ),
              ),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 20,
                    spreadRadius: 2.0,
                    offset: Offset(-10, 7)),
              ],
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.grey,
                  Color.fromARGB(255, 124, 123, 123)
                ],
              ),
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('type', isEqualTo: 'Guard')
                    .where('accepted',
                        arrayContains: FirebaseAuth.instance.currentUser!.uid)
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
                    itemBuilder: (context, index) => SingleJEmployeCard2(
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
