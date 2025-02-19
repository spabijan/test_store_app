import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationLinkText extends StatelessWidget {
  const NavigationLinkText({
    required this.text,
    required this.clickableText,
    required this.navigationRoute,
    super.key,
  });

  final String text;
  final String clickableText;
  final Widget navigationRoute;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text,
            style: GoogleFonts.lato(
                fontWeight: FontWeight.w500, letterSpacing: 1)),
        InkWell(
          onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => navigationRoute)),
          child: Text(clickableText,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold, color: const Color(0xff103de5))),
        )
      ],
    );
  }
}
