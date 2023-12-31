import 'package:flutter/material.dart';
import 'package:guard/admin/utils/utils.dart';
import 'package:guard/users/Screens/Search/FilteredJobs.dart';

class FilterFormJobs extends StatefulWidget {
  @override
  _FilterFormJobsState createState() => _FilterFormJobsState();
}

class _FilterFormJobsState extends State<FilterFormJobs> {
  int _currentStep = 0;

  // For checkboxes and dropdown values
  List<String> _selectedBadgeTypes = [''];
  String _selectedCity = 'Belfast';
  String _selectedJobType = 'Permanent';
  String _selectedShiftType = 'Day';
  final _radiusController = TextEditingController();
  int _radius = 10;
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
    if (_selectedBadgeTypes.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FilteredJobsScreen(
              selectedBadgeTypes: _selectedBadgeTypes,
              selectedJobType: _selectedJobType,
              shift: _selectedShiftType,
              radius: double.parse(
                _radius.toString(),
              ),
            ),
          ));
    } else {
      showSnackBar('Please enter all the feilds', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Filter Results',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(6),
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
            borderRadius: BorderRadius.all(
              Radius.circular(
                (20),
              ),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 20,
                  spreadRadius: 2.0,
                  offset: Offset(-10, 7)),
            ],
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.grey,
                const Color.fromARGB(255, 124, 123, 123)
              ],
            ),
          ),
          child: SingleChildScrollView(
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
                      filterJobs(context);
                      print(_radius);
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Step> _buildSteps() {
    return [
      Step(
        title: Text(
          'Badge Type',
          style: TextStyle(color: Colors.black),
        ),
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
        content: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Radius: $_radius'),
              Slider(
                value: _radius.toDouble(),
                thumbColor: Colors.black,
                activeColor: Colors.white,
                inactiveColor: Colors.black,
                min: 10,
                max: 100,
                divisions:
                    ((100 - 10) / 5).toInt(), // Number of divisions (steps)
                onChanged: (double value) {
                  setState(() {
                    _radius = value.round();
                  });
                },
              ),
            ],
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
