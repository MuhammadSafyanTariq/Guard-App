import 'package:flutter/material.dart';
import 'package:guard/admin/utils/utils.dart';
import 'package:guard/users/Screens/Search/FilteredJobs.dart';

class FilterForm extends StatefulWidget {
  @override
  _FilterFormState createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  int _currentStep = 0;

  // For checkboxes and dropdown values
  List<String> _selectedBadgeTypes = [''];
  String _selectedCity = 'Belfast';
  String _selectedJobType = 'Permanent';
  String _selectedShiftType = 'Day';
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

  Widget buildJobTypeDropdown() {
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
      decoration: InputDecoration(labelText: 'Select Job Type'),
    );
  }

  Widget buildShiftTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedShiftType,
      onChanged: (value) {
        setState(() {
          _selectedShiftType = value!;
        });
      },
      items: [
        DropdownMenuItem(value: 'Day', child: Text('Day')),
        DropdownMenuItem(value: 'Night', child: Text('Night')),
        DropdownMenuItem(value: 'Any', child: Text('Any')),
      ],
      decoration: InputDecoration(labelText: 'Select Shift'),
    );
  }

  filterJobs(BuildContext context) {
    if (_radiusController.text.isNotEmpty && _selectedBadgeTypes.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FilteredJobsScreen(
              selectedBadgeTypes: _selectedBadgeTypes,
              selectedJobType: _selectedJobType,
              shift: _selectedShiftType,
              radius: double.parse(
                _radiusController.text,
              ),
            ),
          ));
    } else {
      showSnackBar('Please enter all the feilds', context);
    }
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
                filterJobs(context);
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
        title: Text('Badge Type'),
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
      Step(
        isActive: true,
        title: Text('Radius'),
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextField(
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
        title: Text('Job Type'),
        content: buildJobTypeDropdown(),
        isActive: true,
      ),
      Step(
        title: Text('Shift Preference'),
        content: buildShiftTypeDropdown(),
        isActive: true,
      ),
    ];
  }
}
