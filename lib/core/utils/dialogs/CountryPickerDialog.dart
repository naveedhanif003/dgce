import 'package:dream_al_emarat_app/core/utils/Utils.dart';
import 'package:flutter/material.dart';

/// **Reusable Country Picker Dialog**
class CountryPickerDialog extends StatefulWidget {
  final Function(String, String) onCountrySelected; // Callback to return country name & code

  const CountryPickerDialog({Key? key, required this.onCountrySelected})
      : super(key: key);

  @override
  _CountryPickerDialogState createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  TextEditingController searchController = TextEditingController();


  List<Map<String, String>> filteredCountries = [];

  @override
  void initState() {
    super.initState();
    filteredCountries = Utils.countryList;
  }

  /// **Search countries by name or code**
  void _filterCountries(String query) {
    setState(() {
      filteredCountries = Utils.countryList
          .where((country) =>
      country["name"]!.toLowerCase().contains(query.toLowerCase()) ||
          country["code"]!.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(10),
        height: 400,
        child: Column(
          children: [
            /// **Search Field**
            TextField(
              controller: searchController,
              onChanged: _filterCountries,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search country...",
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10),

            /// **Country List**
            Expanded(
              child: ListView.builder(
                itemCount: filteredCountries.length,
                itemBuilder: (context, index) {
                  var country = filteredCountries[index];
                  return ListTile(
                    leading: Text(
                      country["code"]!,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    title: Text(
                      country["name"]!,
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      widget.onCountrySelected(country["name"]!, country["code"]!);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
