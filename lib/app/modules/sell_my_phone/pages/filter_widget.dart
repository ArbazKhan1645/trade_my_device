import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  // Define filter options and their states
  final Map<String, bool> brandOptions = {
    'Apple': false,
    'Samsung': false,
    'Google': false,
    'Huawei': false,
  };

  final Map<String, bool> typeOptions = {
    'Mobile-phone': false,
    'Tablet': false,
  };

  // Toggles the selection for a specific option
  void toggleSelection(String category, String option) {
    setState(() {
      if (category == 'Brand') {
        brandOptions[option] = !(brandOptions[option] ?? false);
      } else if (category == 'Type') {
        typeOptions[option] = !(typeOptions[option] ?? false);
      }
    });
  }

  // Get selected options
  List<String> getSelectedOptions(String category) {
    if (category == 'Brand') {
      return brandOptions.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();
    } else if (category == 'Type') {
      return typeOptions.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filters',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        // Brand Filter Section
        const Text(
          'Brand',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        ...brandOptions.keys.map((brand) {
          return CheckboxListTile(
            value: brandOptions[brand],
            title: Text(brand),
            activeColor: Colors.pink,
            onChanged: (value) => toggleSelection('Brand', brand),
            controlAffinity: ListTileControlAffinity.leading,
          );
        }),

        SizedBox(height: 20),
        const Text(
          'Type',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        ...typeOptions.keys.map((type) {
          return CheckboxListTile(
            value: typeOptions[type],
            title: Text(type),
            activeColor: Colors.pink,
            onChanged: (value) => toggleSelection('Type', type),
            controlAffinity:
                ListTileControlAffinity.leading, // Checkbox on the leading side
          );
        }),
      ],
    );
  }
}
