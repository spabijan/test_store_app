import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: GoogleFonts.quicksand(
                  fontSize: 16, fontWeight: FontWeight.w600)),
          Text(subtitle,
              style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue))
        ],
      ),
    );
  }
}
