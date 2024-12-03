import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.text,
    required this.isPass,
    required this.obscureText,
    required this.controller,
    required this.togglePasswordVisibility,
  });

  final text;
  final obscureText;
  final isPass;
  final controller;
  final togglePasswordVisibility;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.labelSmall,
      controller: controller,
      cursorColor: Colors.white,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: isPass ? IconButton(
          onPressed: togglePasswordVisibility,
          icon: Icon(
            obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: Colors.white,
          ),
        ): null,
        filled: false,
        hintText: text,
        hintStyle: GoogleFonts.roboto(
          fontSize: 12,
          color: Colors.white.withOpacity(0.5),
        ),
        labelText: text,
        labelStyle: GoogleFonts.roboto(
          fontSize: 12,
          color: Colors.white.withOpacity(0.5),
        ),
        focusColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white, // Set the desired border color
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.white.withOpacity(0.5), // Set the desired border color
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
