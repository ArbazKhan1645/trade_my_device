// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';

class IMEITextField extends StatefulWidget {
  final Function(String imei) onIMEIComplete;

  const IMEITextField({
    super.key,
    required this.onIMEIComplete,
  });

  @override
  _IMEITextFieldState createState() => _IMEITextFieldState();
}

class _IMEITextFieldState extends State<IMEITextField> {
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
      onChanged: (value) {
        onIMEIChanged(value);
      },
      validator: validateIMEI,
    );
  }
}
