import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/constants/my_colors.dart';
import 'package:test_store_app/constants/my_images.dart';
import 'package:test_store_app/utils/validation_utils.dart';
import 'package:test_store_app/views/screens/authentication/login_screen.dart';
import 'package:test_store_app/views/widgets/authentication_decorated_button.dart';
import 'package:test_store_app/views/widgets/authentication_text_input.dart';
import 'package:test_store_app/views/widgets/navigation_link_text.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.95),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create Your Account',
                    style: GoogleFonts.lato(
                        color: MyColors.defaultFont,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                        fontSize: 23),
                  ),
                  Text('Explore the world exclusives',
                      style: GoogleFonts.lato(
                          fontSize: 12,
                          letterSpacing: 0.2,
                          color: MyColors.defaultFont)),
                  Image.asset(MyImages.ilustrationImagePath,
                      width: 200, height: 200),
                  AuthenticationTextInput(
                      name: 'Email',
                      hintLabel: 'Enter your email',
                      validator: ValidationUtils.emailValidation),
                  const SizedBox(height: 20),
                  AuthenticationTextInput(
                      name: 'Full Name',
                      hintLabel: 'Enter your full name',
                      validator: (fullName) =>
                          ValidationUtils.textNotEmptyValidation(fullName,
                              emptyMessage: 'Enter your full name')),
                  const SizedBox(height: 16),
                  AuthenticationTextInput(
                      name: 'Password',
                      hintLabel: 'Enter your password',
                      validator: ValidationUtils.passwordValidation),
                  const SizedBox(height: 24),
                  AuthenticationDecoratedButton(
                      text: 'Sign Up',
                      onTapButton: () {
                        if (_formKey.currentState!.validate()) {
                          print('correct');
                        } else {
                          print('failed');
                        }
                      }),
                  const SizedBox(height: 20),
                  NavigationLinkText(
                    text: 'Already have an Account',
                    clickableText: 'Sing in',
                    navigationRoute: LoginScreen(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
