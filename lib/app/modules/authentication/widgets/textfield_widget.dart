import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key,
      this.iconbutton,
      required this.hintText,
      this.controller,
      this.observe = false});
  final String hintText;
  final bool observe;
  final IconButton? iconbutton;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12)),
      child: TextField(
        obscureText: observe,
        controller: controller,
        decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.grey),
            suffixIcon: iconbutton,
            contentPadding: const EdgeInsets.all(12),
            border: InputBorder.none,
            hintText: hintText),
      ),
    );
  }
}
