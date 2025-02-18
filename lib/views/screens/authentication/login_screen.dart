import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/constants/my_colors.dart';
import 'package:test_store_app/constants/my_fonts.dart';
import 'package:test_store_app/constants/my_images.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login to Your Account',
              style: GoogleFonts.getFont(MyFonts.lato,
                  color: MyColors.defaultFont,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                  fontSize: 23),
            ),
            Text('Explore the world exclusives',
                style: GoogleFonts.getFont(MyFonts.lato,
                    fontSize: 12,
                    letterSpacing: 0.2,
                    color: MyColors.defaultFont)),
            Image.asset(MyImages.ilustrationImagePath, width: 200, height: 200)
          ],
        ),
      ),
    );
  }
}
