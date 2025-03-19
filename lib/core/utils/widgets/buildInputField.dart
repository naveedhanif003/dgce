import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class buildInputField extends StatefulWidget {
  final String label;
  final IconData? icon;
  final bool isPassword;
  final TextInputType inputType;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  buildInputField({
    required this.label,
    this.icon,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    required this.controller,
    this.validator
  });

  @override
  _buildInputField createState() => _buildInputField();
}

class _buildInputField extends State<buildInputField> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          validator: widget.validator,
          controller: widget.controller,
          obscureText: widget.isPassword ? isObscured : false,
          keyboardType: widget.inputType,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            hintText: widget.label,
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: widget.icon != null
                ? Icon(widget.icon, color: Colors.white)
                : null, // Hide if icon is not provided
            suffixIcon:
                widget.isPassword
                    ? IconButton(
                      icon: Icon(
                        isObscured ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          isObscured = !isObscured;
                        });
                      },
                    )
                    : null,
            contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: AppColors.goldColor),
            ),
          ),
        ),
      ],
    );
  }
}