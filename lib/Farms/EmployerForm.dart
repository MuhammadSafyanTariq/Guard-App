import 'package:flutter/material.dart';
import 'package:guard/Screens/MainPage2.dart';

class EmployerForm extends StatefulWidget {
  @override
  _EmployerFormState createState() => _EmployerFormState();
}

class _EmployerFormState extends State<EmployerForm> {
  int _currentStep = 0;

  final List<Step> _steps = [
    Step(
      title: Text('Company Information'),
      content: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Company Name'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Address'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Phone Number'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Corresponding Person Name'),
          ),
        ],
      ),
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Employer Registration'),
      ),
      body: Stepper(
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage2(),
              ), // Replace with the actual route
            );
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
    );
  }
}
