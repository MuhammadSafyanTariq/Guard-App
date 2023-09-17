import 'package:flutter/material.dart';
import 'package:guard/admin/Resource/Auth_Methods.dart';
import 'package:guard/users/Resource/Post_Job.dart';
import 'package:guard/users/utils/utils.dart';

class JobForm extends StatefulWidget {
  @override
  _JobFormState createState() => _JobFormState();
}

class _JobFormState extends State<JobForm> {
  int _currentStep = 0;

  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _corresPersonController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  final JobMethods _jobMethods = JobMethods();

  Future<String> postJob() async {
    String res = '';

    res = await _jobMethods.postJob(
      title: _jobTitleController.text,
      description: _descController.text,
      email: _emailController.text,
      city: _cityController.text,
    );
    setState(() {});
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
              controller: _jobTitleController,
              decoration: InputDecoration(labelText: 'Job Title'),
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(labelText: 'Job Description'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Contact Email'),
            ),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(labelText: 'City'),
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
    _jobTitleController.dispose();
    _descController.dispose();
    _emailController.dispose();
    _cityController.dispose();
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
      body: SingleChildScrollView(
        child: Column(
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
            ElevatedButton(
              onPressed: () {
                postJob();
              },
              child: Text('Post Job'),
            ),
          ],
        ),
      ),
    );
  }
}
