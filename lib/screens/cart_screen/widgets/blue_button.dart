import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class BlueButton extends StatelessWidget {
  const BlueButton({required this.textButton, required this.onTap, super.key});

  final String textButton;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 338,
        height: 58,
        decoration: BoxDecoration(
            color: const Color(0xff3854ee),
            borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(textButton,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
        ),
      ),
    );
  }
}
