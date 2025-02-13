// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IMEITextField extends StatefulWidget {
  final Function(String imei)
      onIMEIComplete; // Callback for when IMEI is complete

  const IMEITextField({
    super.key,
    required this.onIMEIComplete,
  });

  @override
  _IMEITextFieldState createState() => _IMEITextFieldState();
}

class _IMEITextFieldState extends State<IMEITextField> {
  // Validate IMEI - Should be 15 digits
  String? validateIMEI(String? imei) {
    if (imei == null || imei.isEmpty) {
      return 'IMEI is required';
    } else if (imei.length != 15) {
      return 'IMEI must be 15 digits';
    } else if (!RegExp(r'^\d+$').hasMatch(imei)) {
      return 'IMEI must contain only digits';
    }
    return null;
  }

  // Called when IMEI field changes
  void onIMEIChanged(String imei) {
    widget.onIMEIComplete(imei);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Search for your device or IMEI number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [],
      onChanged: (value) {
        onIMEIChanged(value);
      },
      validator: validateIMEI,
    );
  }
}
