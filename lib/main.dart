import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Donation Form',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: BloodDonationForm(),
    );
  }
}

class BloodDonationForm extends StatefulWidget {
  @override
  _BloodDonationFormState createState() => _BloodDonationFormState();
}

class _BloodDonationFormState extends State<BloodDonationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usnController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _numDonationsController = TextEditingController();
  final TextEditingController _lastDonationDateController =
      TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  String _gender = 'Male';
  String _bloodGroup = 'A RhD positive (A+)';
  String _donatedPlatelets = 'No';
  String _medicalCondition = 'No';
  String _drinkingSmoking = 'No';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null)
      setState(() {
        _lastDonationDateController.text =
            DateFormat('yyyy-MM-dd').format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Donation Form'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.red,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTextField(
                  _emailController, 'Email ID', TextInputType.emailAddress),
              _buildTextField(
                  _nameController, 'Name of the Donor', TextInputType.text),
              _buildTextField(_usnController, 'USN', TextInputType.text),
              _buildTextField(
                  _ageController, 'Donor Age', TextInputType.number),
              _buildDropdownField(
                  'Donor Gender', ['Male', 'Female', 'Non binary'], _gender,
                  (String? newValue) {
                setState(() {
                  _gender = newValue!;
                });
              }),
              _buildDropdownField(
                  'Donor Blood group',
                  [
                    'A RhD positive (A+)',
                    'A RhD negative (A-)',
                    'B RhD positive (B+)',
                    'B RhD negative (B-)',
                    'O RhD positive (O+)',
                    'O RhD negative (O-)',
                    'AB RhD positive (AB+)',
                    'AB RhD negative (AB-)',
                  ],
                  _bloodGroup, (String? newValue) {
                setState(() {
                  _bloodGroup = newValue!;
                });
              }),
              _buildTextField(_mobileController, 'Donor mobile number',
                  TextInputType.phone),
              _buildTextField(
                  _pincodeController, 'Address Pin code', TextInputType.number),
              _buildDropdownField('Have you donated platelets', ['Yes', 'No'],
                  _donatedPlatelets, (String? newValue) {
                setState(() {
                  _donatedPlatelets = newValue!;
                });
              }),
              _buildTextField(_numDonationsController, 'Number of donations',
                  TextInputType.number),
              _buildDateField(context, 'Last date of donation'),
              _buildDropdownField('Are you under any medical condition',
                  ['Yes', 'No'], _medicalCondition, (String? newValue) {
                setState(() {
                  _medicalCondition = newValue!;
                });
              }),
              _buildDropdownField(
                  'Drinking and smoking?', ['Yes', 'No'], _drinkingSmoking,
                  (String? newValue) {
                setState(() {
                  _drinkingSmoking = newValue!;
                });
              }),
              _buildTextField(
                  _experienceController,
                  'Write a few lines about your blood donation experience',
                  TextInputType.multiline,
                  maxLines: 3),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(
                    fontSize: 20,
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

  Widget _buildTextField(TextEditingController controller, String labelText,
      TextInputType keyboardType,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField(String labelText, List<String> options,
      String currentValue, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: currentValue,
            isExpanded: true,
            onChanged: onChanged,
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _lastDonationDateController,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        onTap: () => _selectDate(context),
        readOnly: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select $labelText';
          }
          return null;
        },
      ),
    );
  }
}
