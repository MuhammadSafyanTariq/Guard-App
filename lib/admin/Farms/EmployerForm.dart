import 'package:flutter/material.dart';
import 'package:guard/admin/Resource/Auth_Methods.dart';
import 'package:guard/users/utils/utils.dart';

class EmployerForm extends StatefulWidget {
  @override
  _EmployerFormState createState() => _EmployerFormState();
}

class _EmployerFormState extends State<EmployerForm> {
  int _currentStep = 0;

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _corresPersonController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  final AuthMethods _authMethods = AuthMethods();

  Future<String> SignUpUser() async {
    String res = '';
    setState(() {
      _isLoading = true;
    });
    res = await _authMethods.signUpUser(
        companyName: _companyNameController.text,
        address: _addressController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        correspondingPerson: _corresPersonController.text,
        password: _passwordController.text);
    // setState(() {
    //   _isLoading = false;
    // });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {}
    return res;
  }

  late List<Step> _steps;

  @override
  void initState() {
    super.initState();

    // Initialize the `_corresPersonController` variable here.

    // Initialize the _steps list here.
    _steps = [
      Step(
        title: Text('Company Information'),
        content: Column(
          children: [
            TextField(
              controller: _companyNameController,
              decoration: InputDecoration(labelText: 'Company Name'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _corresPersonController,
              decoration:
                  InputDecoration(labelText: 'Corresponding Person Name'),
            ),
          ],
        ),
        isActive: true,
      ),
    ];
  }

  @override
  void dispose() {
    // Dispose of the TextEditingControllers here.
    _companyNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _corresPersonController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Employer Registration'),
      ),
      body: Column(
        children: [
          Stepper(
            steps: _steps,
            currentStep: _currentStep,
            onStepTapped: (step) {
              setState(() {
                _currentStep = step;
              });
            },
            onStepContinue: () {
              if (_currentStep < _steps.length - 1) {
                setState(() {
                  _currentStep++;
                });
              } else {
                // Replace this with your navigation logic
                // For example, you can use Navigator to push to the next screen.
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => MainPage2(),
                //   ),
                // );
              }
            },
            onStepCancel: () {
              if (_currentStep > 0) {
                setState(() {
                  _currentStep--;
                });
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              SignUpUser();
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) =>
              //           MainPage()), // Replace with the actual route
              // );
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
