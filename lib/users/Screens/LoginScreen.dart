import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guard/Employer/Screen/MainPage2.dart';
import 'package:guard/users/Resource/Auth_Methods.dart';
import 'package:guard/users/Screens/MainPage.dart';
import 'package:guard/users/utils/utils.dart';

import 'RegistrationScreen.dart'; //

String? type;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final AuthMethods _authMethods = AuthMethods();
  var userData = {};
  @override
  void initState() {
    super.initState();
  }

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

  void LoginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await _authMethods.loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == "success") {
      await getData();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => userData['type'] == "employer"
              ? MainPage2()
              : userData['type'] == 'Guard'
                  ? MainPage()
                  : Container(
                      child: const Center(
                      child: Text("Check your Network connection"),
                    )),
        ),
      );
    } else {
      showSnackBar(res, context);
    }
  }

  forgetPassword() async {
    setState(() {
      _isLoading = true;
    });
    String res = await _authMethods.resetPassword(_emailController.text);
    if (res == "success") {
      showSnackBar('Password reset sent at your email', context);
    } else {
      showSnackBar(res, context);
    }
  }

  void goTOSignUpScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Container(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(type);
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.all(20),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  forgetPassword();
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  LoginUser();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationScreen()),
                  );
                },
                child: const Text(
                  'Don\'t have an account? Register',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
