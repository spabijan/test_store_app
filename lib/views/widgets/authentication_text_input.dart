import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/constants/my_images.dart';

class AuthenticationTextInput extends StatelessWidget {
  AuthenticationTextInput({
    required this.name,
    required this.hintLabel,
    this.validator,
    super.key,
  });
  final String name;
  final String hintLabel;
  FormFieldValidator<String>? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(name,
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600, letterSpacing: 0.2))),
        TextFormField(
          validator: validator,
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(MyImages.emailIcon, width: 16, height: 16),
              ),
              labelText: hintLabel,
              labelStyle:
                  GoogleFonts.nunitoSans(fontSize: 14, letterSpacing: 0.1),
              fillColor: Colors.white,
              filled: true,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
        ),
      ],
    );
  }
}
