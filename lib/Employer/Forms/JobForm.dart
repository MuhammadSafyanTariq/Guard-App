import 'package:flutter/material.dart';
import 'package:guard/Employer/Resources/Post_Job.dart';
import 'package:guard/Employer/Screen/MainPage2.dart';
import 'package:guard/users/Screens/JobDetails.dart';
import 'package:guard/users/utils/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

class JobForm extends StatefulWidget {
  const JobForm({super.key});

  @override
  _JobFormState createState() => _JobFormState();
}

class _JobFormState extends State<JobForm> {
  final String _selectedLocation =
      'Belfast'; // Set an initial value from the list
  String _selectedShift = 'Day'; // Set an initial value from the list
  String _selectedRateType = 'Per Hour'; // Set an initial value from the list
  String _selectedJobType = 'Permanent'; // Set an initial value from the list
  String _selectedBadge = 'Security Guard';

  final List<String> _jobBadges = [
    'Security Guard',
    'Door Supervisor',
    'CCTV',
    'Close Protection',
  ];

  final List<String> _shifts = [
    'Day',
    'Night',
  ];
  final List<String> _rateTypes = [
    'Per Hour',
    'Per Day',
    'Per Shift',
    'Per Month'
  ];
  final List<String> _jobTypes = ['Permanent', 'Part-time', 'Cover'];

  final _positionController = TextEditingController();
  final _rateController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _correspondingPersonController =
      TextEditingController();
  final TextEditingController _benefitsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  late double latitude;
  late double longitude;

  Future<String> fetchLocationInfo(String postalCode) async {
    String res = 'Some error occured';

    var status = await Permission.location.request();
    if (status.isGranted) {
      try {
        List<Location> locations = await locationFromAddress(postalCode);

        if (locations.isNotEmpty) {
          Location firstLocation = locations.first;
          latitude = firstLocation.latitude;
          longitude = firstLocation.longitude;

          List<Placemark> placemarks = await placemarkFromCoordinates(
            latitude,
            longitude,
          );
          res = 'success';
        } else {
          showSnackBar('Some problem occured check your postal code', context);
        }
      } catch (e) {
        showSnackBar('Some problem occured check your postal code', context);
      }
    } else if (status.isDenied) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage2(),
          ),
          (route) => false);
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }

    return res;
  }

  Widget buildBadgeDropdown() {
    List<DropdownMenuItem<String>> items = _jobBadges.map((city) {
      return DropdownMenuItem<String>(value: city, child: Text(city));
    }).toList();

    return DropdownButtonFormField<String>(
      value: _selectedBadge,
      onChanged: (value) {
        setState(() {
          _selectedBadge = value!;
        });
      },
      items: items,
      decoration: const InputDecoration(labelText: 'Select Badge'),
    );
  }

  void _navigateToAdDetailsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdDetailsPage(
          position: _positionController.text,
          shift: _selectedShift,
          rate: _rateController.text,
          rateType: _selectedRateType,
          venue: _venueController.text,
          correspondingPerson: _correspondingPersonController.text,
          jobType: _selectedJobType,
          benefits: _benefitsController.text,
          description: _descriptionController.text,
          email: _emailController.text,
          address: _addressController.text,
        ),
      ),
    );
  }

  bool _isLoading = false;
  final JobMethods _jobMethods = JobMethods();

  Future<String> postJob() async {
    String res = '';
    setState(() {
      _isLoading = true;
    });

    res = await _jobMethods.postJob(
        title: _titleController.text,
        description: _descriptionController.text,
        email: _emailController.text,
        benefits: _benefitsController.text,
        correspondingPerson: _correspondingPersonController.text,
        jobType: _selectedJobType ?? '',
        location: _selectedLocation,
        position: _positionController.text,
        rate: _rateController.text,
        rateType: _selectedRateType ?? '',
        shift: _selectedShift ?? '',
        venue: _venueController.text,
        jobBadge: _selectedBadge,
        latitude: latitude,
        longitude: longitude,
        address: _addressController.text);

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      _navigateToAdDetailsPage();
    }

    setState(() {
      _isLoading = false;
    });

    return res;
  }

  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[600],
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          gradient: const LinearGradient(
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'MY JOB',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: H * 0.03),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Job title',
                  labelStyle:
                      TextStyle(color: Colors.black), // Change label color
                ),
              ),
              TextField(
                controller: _positionController,
                decoration: const InputDecoration(
                  labelText: 'Position',
                  labelStyle:
                      TextStyle(color: Colors.black), // Change label color
                ),
              ),
              const SizedBox(height: 20),
              buildBadgeDropdown(),
              const SizedBox(height: 20),
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
                decoration: const InputDecoration(labelText: 'Shift'),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _rateController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Rate'),
                    ),
                  ),
                  const SizedBox(width: 20),
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
                      decoration: const InputDecoration(labelText: 'Rate Type'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _venueController,
                decoration: const InputDecoration(labelText: 'Venue'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _postalCodeController,
                decoration: const InputDecoration(labelText: 'Postal Code'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _correspondingPersonController,
                decoration:
                    const InputDecoration(labelText: 'Corresponding Person'),
              ),
              const SizedBox(height: 20),
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
                decoration: const InputDecoration(labelText: 'Job Type'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _benefitsController,
                decoration: const InputDecoration(labelText: 'Benefits'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Contact Email'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      fetchLocationInfo(_postalCodeController.text);
                      postJob();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Text(
                      'Post',
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
