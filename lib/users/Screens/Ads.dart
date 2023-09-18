import 'package:flutter/material.dart';
import 'package:guard/users/Screens/JobDetails.dart';

class Ads extends StatefulWidget {
  @override
  _AdsState createState() => _AdsState();
}

class _AdsState extends State<Ads> {
  String _selectedLocation = 'City 1'; // Set an initial value from the list
  String _selectedShift = 'Day'; // Set an initial value from the list
  String _selectedRateType = 'Per Hour'; // Set an initial value from the list
  String _selectedJobType = 'Permanent'; // Set an initial value from the list

  List<String> _locations = ['City 1', 'City 2', 'City 3', 'City 4'];
  List<String> _shifts = ['Day', 'Night', 'Other'];
  List<String> _rateTypes = ['Per Hour', 'Per Day', 'Per Shift', 'Per Month'];
  List<String> _jobTypes = ['Permanent', 'Part-time', 'Cover'];

  TextEditingController _positionController = TextEditingController();
  TextEditingController _rateController = TextEditingController();
  TextEditingController _venueController = TextEditingController();
  TextEditingController _correspondingPersonController =
      TextEditingController();
  TextEditingController _benefitsController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  void _navigateToAdDetailsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdDetailsPage(
          position: _positionController.text,
          location: _selectedLocation,
          shift: _selectedShift,
          rate: _rateController.text,
          rateType: _selectedRateType,
          venue: _venueController.text,
          correspondingPerson: _correspondingPersonController.text,
          jobType: _selectedJobType,
          benefits: _benefitsController.text,
          description: _descriptionController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[600],
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color.fromARGB(255, 189, 187, 187),
              Color.fromARGB(255, 157, 156, 156)
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'My Ad',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: H * 0.03),
              TextField(
                controller: _positionController,
                decoration: InputDecoration(
                  labelText: 'Position',
                  labelStyle:
                      TextStyle(color: Colors.black), // Change label color
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedLocation,
                onChanged: (value) {
                  setState(() {
                    _selectedLocation = value!;
                  });
                },
                items: _locations.map((location) {
                  return DropdownMenuItem(
                    value: location,
                    child: Text(location,
                        style: TextStyle(
                            color: Colors.black)), // Change text color
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Location',
                  labelStyle:
                      TextStyle(color: Colors.black), // Change label color
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedShift,
                onChanged: (value) {
                  setState(() {
                    _selectedShift = value!;
                  });
                },
                items: _shifts.map((shift) {
                  return DropdownMenuItem(
                    value: shift,
                    child: Text(shift),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Shift'),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _rateController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Rate'),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 3,
                    child: DropdownButtonFormField<String>(
                      value: _selectedRateType,
                      onChanged: (value) {
                        setState(() {
                          _selectedRateType = value!;
                        });
                      },
                      items: _rateTypes.map((rateType) {
                        return DropdownMenuItem(
                          value: rateType,
                          child: Text(rateType),
                        );
                      }).toList(),
                      decoration: InputDecoration(labelText: 'Rate Type'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: _venueController,
                decoration: InputDecoration(labelText: 'Venue'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _correspondingPersonController,
                decoration: InputDecoration(labelText: 'Corresponding Person'),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedJobType,
                onChanged: (value) {
                  setState(() {
                    _selectedJobType = value!;
                  });
                },
                items: _jobTypes.map((jobType) {
                  return DropdownMenuItem(
                    value: jobType,
                    child: Text(jobType),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Job Type'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _benefitsController,
                decoration: InputDecoration(labelText: 'Benefits'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed:
                        _navigateToAdDetailsPage, // Navigate to AdDetailsPage
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: Text(
                      '   Post   ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _positionController.dispose();
    _rateController.dispose();
    _venueController.dispose();
    _correspondingPersonController.dispose();
    _benefitsController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
