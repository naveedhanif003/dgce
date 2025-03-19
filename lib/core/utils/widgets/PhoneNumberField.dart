import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../Utils.dart';
import '../dialogs/CountryPickerDialog.dart';

/// **Phone Number Input Field with Country Picker Dialog**
class PhoneNumberField extends StatefulWidget {
  final TextEditingController controller;
  final String selectedCountryCode;
  final Function(String, String) onCountryChanged;
  final String? Function(String?)? validator;

  const PhoneNumberField({
    Key? key,
    required this.controller,
    required this.selectedCountryCode,
    required this.onCountryChanged,
    this.validator,
  }) : super(key: key);

  @override
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  late String selectedCode;
  late String selectedCountry;

  @override
  void initState() {
    super.initState();
    selectedCode = widget.selectedCountryCode;
    selectedCountry = _getCountryName(widget.selectedCountryCode);
  }

  /// **Get country name from code**
  String _getCountryName(String code) {
    return Utils.countryList.firstWhere(
          (country) => country["code"] == code,
      orElse: () => {"name": "Unknown", "code": code},
    )["name"]!;
  }

  /// **Open Country Picker Dialog**
  void _openCountryPicker() {
    showDialog(
      context: context,
      builder: (context) => CountryPickerDialog(
        onCountrySelected: (String countryName, String countryCode) {
          setState(() {
            selectedCode = countryCode;
            selectedCountry = countryName;
          });
          widget.onCountryChanged(countryName, countryCode);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone Number",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.white),
          ),
          child: Row(
            children: [
              /// **Country Picker Button**
              GestureDetector(
                onTap: _openCountryPicker,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.white)),
                  ),
                  child: Text(
                    selectedCode,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),

              /// **Phone Number Input Field**
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  keyboardType: TextInputType.phone,
                  validator: widget.validator,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter phone number",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
