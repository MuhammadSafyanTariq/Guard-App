import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guard/MainScreen.dart';
import 'package:guard/users/Provider/user_provider.dart';
import 'package:guard/Employer/Forms/JobForm.dart';
import 'package:guard/users/Screens/Invite.dart';
import 'package:guard/users/Screens/JobDetails.dart';
import 'package:guard/Employer/Screen/EmployeJob.dart';
import 'package:guard/users/Screens/LoginScreen.dart';
import 'package:guard/users/Screens/MainPage.dart';
import 'package:guard/Employer/Screen/MainPage2.dart';
import 'package:guard/Employer/Screen/PostJobs.dart';
import 'package:guard/users/Screens/MyJobs.dart';
import 'package:guard/users/Screens/Profile.dart';
import 'package:guard/users/Screens/RegistrationScreen.dart';
import 'package:guard/users/utils/utils.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyC5PmBKBX1J_4TkzSsqclq2KGbYzL3Svzs',
        appId: '1:1069664606978:web:4fd780eeb05a3cb468001b',
        messagingSenderId: '1069664606978',
        projectId: 'gaurdpass',
        authDomain: 'gaurdpass.firebaseapp.com',
        storageBucket: 'gaurdpass.appspot.com',
        measurementId: 'G-P618QF7CST',
      ),
    );
  } else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyAfx5wXFofo14szyuCYfa0DGRUt1ormCIE',
      appId: '1:1069664606978:android:3142a12490d3631f68001b',
      messagingSenderId: '1069664606978',
      authDomain: 'gaurdpass.firebaseapp.com',
      projectId: 'gaurdpass',
      storageBucket: 'gaurdpass.appspot.com',
      measurementId: 'G-P618QF7CST',
    ));
  }
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // _auth.signOut();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var userData = {};

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (userSnap.exists) {
        userData = userSnap.data() as Map<String, dynamic>;
        type = userData['type'];
        //I am getting correct user type here
        print('User type: $type');
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SIA',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                // But wrong here
                print('-=-=-=-====================$type');
                return AnimatedSplashScreen(
                  duration: 1000,
                  splashIconSize: 300,
                  splash: const Text('Guard Pass'),
                  splashTransition: SplashTransition.slideTransition,
                  backgroundColor: Colors.black,
                  nextScreen: getUserTypeScreen(type),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // User is not logged in
            return AnimatedSplashScreen(
              duration: 1000,
              splashIconSize: 250,
              splash: const Text('Guard Pass'),
              splashTransition: SplashTransition.slideTransition,
              backgroundColor: Colors.black,
              nextScreen: LoginScreen(),
            );
          },
        ),
      ),
    );
  }

  Widget getUserTypeScreen(String? userType) {
    // Add logic to return the appropriate screen based on the user's type
    if (userType == "employer") {
      return MainPage2();
    } else {
      return MainPage();
    }
  }
}
