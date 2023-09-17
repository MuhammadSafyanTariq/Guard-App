// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Your App Name',
//       theme: ThemeData(
//         primarySwatch: Colors.blue, // Set your app's theme colors
//       ),
//       home: LoginScreen(), // Replace with your actual login screen widget
//     );
//   }
// }

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guard/Provider/user_provider.dart';
import 'package:guard/Screens/LoginScreen.dart';
import 'package:guard/Screens/MainPage.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //FirebaseAuth.instance.signOut();
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return AnimatedSplashScreen(
                  duration: 1000,
                  splashIconSize: 300,
                  splash: const Text('Guard Pass'),
                  // splash: const Image(
                  //   image: AssetImage(
                  //     'assets/Bunny.png',
                  //   ),
                  // ),
                  splashTransition: SplashTransition.slideTransition,
                  backgroundColor: Colors.black,
                  nextScreen: MainPage(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

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
}
