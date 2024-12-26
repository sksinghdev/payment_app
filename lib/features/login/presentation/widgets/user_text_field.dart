import 'package:flutter/material.dart';

class UserTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  const UserTextField({super.key, required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
   

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none),
      ),
    );
  }
}
