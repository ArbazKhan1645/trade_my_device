import 'package:flutter/material.dart';
import 'package:trademydevice/app/core/utils/thems/theme.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isRequired;
  final TextEditingController? controller;
  final bool readonly;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    this.hintText = '',
    this.readonly = false,
    this.isRequired = false,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: defaultTextStyle,
            children: isRequired
                ? [
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          readOnly: readonly,
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an $label';
                }

                return null;
              },
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter $label',
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(
                color: Colors.blue, // Focused border color
              ),
            ),
          ),
        ),
      ],
    );
  }
}
