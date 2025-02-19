import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationDecoratedButton extends StatelessWidget {
  const AuthenticationDecoratedButton(
      {required this.text, super.key, this.onTapButton});

  final String text;
  final void Function()? onTapButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapButton,
      child: Container(
          width: 319,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                  colors: [Color(0xFF102DE1), Color(0xCC0D63FF)])),
          child: Stack(children: [
            Positioned(
                left: 278,
                top: 19,
                child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      width: 60,
                      height: 60,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 12, color: const Color(0xFF103DE5)),
                          borderRadius: BorderRadius.circular(30)),
                    ))),
            Positioned(
              left: 311,
              top: 36,
              child: Opacity(
                  opacity: 0.3,
                  child: Container(
                    width: 5,
                    height: 5,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white),
                  )),
            ),
            Positioned(
              left: 281,
              top: -10,
              child: Opacity(
                  opacity: 0.3,
                  child: Container(
                    width: 20,
                    height: 20,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                  )),
            ),
            Center(
                child: Text(text,
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)))
          ])),
    );
  }
}
