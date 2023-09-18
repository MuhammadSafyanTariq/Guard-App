import 'package:flutter/material.dart';
import 'package:guard/Employer/Resources/Post_Job.dart';
import 'package:guard/users/utils/utils.dart';

class JobForm extends StatefulWidget {
  @override
  _JobFormState createState() => _JobFormState();
}

class _JobFormState extends State<JobForm> {
  bool _isLoading = false;
  final JobMethods _jobMethods = JobMethods();

  Future<String> postJob() async {
    String res = '';
    setState(() {
      _isLoading = true;
    });

    res = await _jobMethods.postJob(
      title: _jobTitleController.text,
      description: _descController.text,
      email: _emailController.text,
      city: _selectedCity ?? '',
      benefits: _benefitsController.text,
      correspondingPerson: _corresPersonController.text,
      jobType: _selectedJobType ?? '',
      location: _locationController.text,
      position: _positionController.text,
      rate: _rateController.text,
      rateType: _selectedRateType ?? '',
      shift: _selectedShift ?? '',
      venue: _venueController.text,
    );

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      // Navigate to the success screen or perform other actions
    }

    setState(() {
      _isLoading = false;
    });

    return res;
  }

  int _currentStep = 0;

  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _corresPersonController = TextEditingController();
  final TextEditingController _benefitsController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();

  String? _selectedCity;
  String? _selectedShift;
  String? _selectedJobType;
  String? _selectedRateType;

  List<String> cities = [
    'Belfast',
    'Birmingham',
    'Bradford',
    // Add more cities here
  ];

  List<String> shifts = [
    'Day',
    'Night',
    'Any',
  ];

  List<String> jobTypes = [
    'Security Guard',
    'Door Supervisor',
    'CCTV',
    'Close Protection',
    // Add more job types here
  ];

  List<String> rateTypes = [
    'Hourly',
    'Weekly',
    'Monthly',
    // Add more rate types here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Post A Job'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stepper(
              steps: _buildSteps(),
              currentStep: _currentStep,
              onStepTapped: (step) {
                setState(() {
                  _currentStep = step;
                });
              },
              onStepContinue: () {
                if (_currentStep < _buildSteps().length - 1) {
                  setState(() {
                    _currentStep++;
                  });
                } else {
                  postJob();
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

  List<Step> _buildSteps() {
    return [
      Step(
        title: Text('Job information'),
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
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text('City'),
        content: Column(
          children: [
            buildCityDropdown(),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text('Benefits'),
        content: Column(
          children: [
            TextField(
              controller: _benefitsController,
              decoration: InputDecoration(labelText: 'Benefits'),
            ),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text('Corresponding Person'),
        content: Column(
          children: [
            TextField(
              controller: _corresPersonController,
              decoration: InputDecoration(labelText: 'Corresponding Person'),
            ),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text('Location'),
        content: Column(
          children: [
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text('Position'),
        content: Column(
          children: [
            TextField(
              controller: _positionController,
              decoration: InputDecoration(labelText: 'Position'),
            ),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text('Rate'),
        content: Column(
          children: [
            TextField(
              controller: _rateController,
              decoration: InputDecoration(labelText: 'Rate'),
            ),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text('Rate Type'),
        content: Column(
          children: [
            buildRateTypeDropdown(),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text('Shift'),
        content: Column(
          children: [
            buildShiftDropdown(),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text('Job Type'),
        content: Column(
          children: [
            buildJobTypeCheckbox('Security Guard'),
            buildJobTypeCheckbox('Door Supervisor'),
            buildJobTypeCheckbox('CCTV'),
            buildJobTypeCheckbox('Close Protection'),
            // Add more job types here
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text('Venue'),
        content: Column(
          children: [
            TextField(
              controller: _venueController,
              decoration: InputDecoration(labelText: 'Venue'),
            ),
          ],
        ),
        isActive: true,
      ),
    ];
  }

  Widget buildCityDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCity ?? cities[0],
      onChanged: (value) {
        setState(() {
          _selectedCity = value;
        });
      },
      items: cities.map((city) {
        return DropdownMenuItem<String>(value: city, child: Text(city));
      }).toList(),
      decoration: InputDecoration(labelText: 'Select City'),
    );
  }

  Widget buildShiftDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedShift,
      onChanged: (value) {
        setState(() {
          _selectedShift = value;
        });
      },
      items: shifts.map((shift) {
        return DropdownMenuItem<String>(value: shift, child: Text(shift));
      }).toList(),
      decoration: InputDecoration(labelText: 'Select Shift'),
    );
  }

  Widget buildRateTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedRateType,
      onChanged: (value) {
        setState(() {
          _selectedRateType = value;
        });
      },
      items: rateTypes.map((rateType) {
        return DropdownMenuItem<String>(
          value: rateType,
          child: Text(rateType),
        );
      }).toList(),
      decoration: InputDecoration(labelText: 'Select Rate Type'),
    );
  }

  Widget buildJobTypeCheckbox(String title) {
    return CheckboxListTile(
      title: Text(title),
      value: _selectedJobType == title,
      onChanged: (value) {
        setState(() {
          _selectedJobType = value! ? title : null;
        });
      },
    );
  }
}
