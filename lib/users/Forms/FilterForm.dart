import 'package:flutter/material.dart';
import 'package:guard/users/Resource/Auth_Methods.dart';
import 'package:guard/users/Screens/MainPage.dart';
import 'package:guard/users/Screens/Search/FilteredJobs.dart';
import 'package:guard/users/utils/utils.dart';
import 'package:uuid/uuid.dart';

class FilterForm extends StatefulWidget {
  @override
  _FilterFormState createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  bool _isLoading = false;
  final AuthMethods _authMethods = AuthMethods();

  int _currentStep = 0;

  // For checkboxes and dropdown values
  List<String> _selectedBadgeTypes = [''];
  List<String> _selectedDrivingLicense = [];
  String _selectedCity = 'Belfast';
  String _selectedJobType = 'Permanent';
  final _radiusController = TextEditingController();

  Widget buildBadgeTypeCheckbox(String title) {
    return CheckboxListTile(
      title: Text(title),
      value: _selectedBadgeTypes.contains(title),
      onChanged: (value) {
        setState(() {
          if (value ?? false) {
            _selectedBadgeTypes.add(title);
          } else {
            _selectedBadgeTypes.remove(title);
          }
        });
      },
    );
  }

  Widget buildShiftDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedJobType,
      onChanged: (value) {
        setState(() {
          _selectedJobType = value!;
        });
      },
      items: [
        DropdownMenuItem(value: 'Permanent', child: Text('Permanent')),
        DropdownMenuItem(value: 'Part-time', child: Text('Part-time')),
        DropdownMenuItem(value: 'Cover', child: Text('Cover')),
      ],
      decoration: InputDecoration(labelText: 'Select Shift'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Filter Results',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
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
                } else {}
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FilteredJobsScreen(
                        selectedBadgeTypes: _selectedBadgeTypes,
                        selectedJobType: _selectedJobType,
                        selectedCity: _selectedCity,
                        radius: double.parse(
                          _radiusController.text,
                        )),
                  ),
                );
              },
              child: Text('Filter'),
            ),
          ],
        ),
      ),
    );
  }

  List<Step> _buildSteps() {
    return [
      Step(
        title: Text('Licence Type'),
        content: Column(
          children: [
            buildBadgeTypeCheckbox('Security Guard'),
            buildBadgeTypeCheckbox('Door Supervisor'),
            buildBadgeTypeCheckbox('CCTV'),
            buildBadgeTypeCheckbox('Close Protection'),
          ],
        ),
        isActive: true,
      ),
      // Step(
      //   title: Text('Driving License'),
      //   content: Column(
      //     children: [
      //       buildLicenceCheckbox('UK Full'),
      //       buildLicenceCheckbox('UK Automatic'),
      //       buildLicenceCheckbox('EU License'),
      //       buildLicenceCheckbox('International License'),
      //       buildLicenceCheckbox('No License'),
      //     ],
      //   ),
      //   isActive: true,
      // ),
      Step(
        title: Text('Radius'),
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            obscureText: true,
            controller: _radiusController,
            decoration: InputDecoration(
              labelText: 'Radius',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
      Step(
        title: Text('Shift Preference'),
        content: buildShiftDropdown(),
        isActive: true,
      ),
    ];
  }
}
