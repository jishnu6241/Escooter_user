import 'package:flutter/material.dart';

class CustomInputFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?)? validator;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final String labelText;
  final int maxLines;
  final bool isObscure;
  final TextInputType? keyboardType;
  const CustomInputFormField({
    super.key,
    required this.controller,
    required this.validator,
    this.suffixIcon,
    this.prefixIcon,
    required this.labelText,
    this.maxLines = 1,
    this.isObscure = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboardType,
      validator: (value) => validator!(value),
      decoration: InputDecoration(
        hintText: labelText,
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.greenAccent,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
