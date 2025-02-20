import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/constants/my_colors.dart';
import 'package:test_store_app/constants/my_images.dart';
import 'package:test_store_app/controllers/auth_controller.dart';
import 'package:test_store_app/utils/validation_utils.dart';
import 'package:test_store_app/views/screens/authentication/register_screen.dart';
import 'package:test_store_app/views/widgets/authentication_decorated_button.dart';
import 'package:test_store_app/views/widgets/authentication_text_input.dart';
import 'package:test_store_app/views/widgets/navigation_link_text.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email;
  late String password;

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
                    'Login to Your Account',
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
                      onChanged: (text) => email = text,
                      name: 'Email',
                      hintLabel: 'Enter your email',
                      validator: ValidationUtils.emailValidation),
                  const SizedBox(height: 16),
                  AuthenticationTextInput(
                      onChanged: (text) => password = text,
                      name: 'Password',
                      hintLabel: 'Enter your password',
                      validator: ValidationUtils.passwordValidation),
                  const SizedBox(height: 24),
                  AuthenticationDecoratedButton(
                      text: 'Sign In',
                      onTapButton: () async {
                        if (_formKey.currentState!.validate()) {
                          await GetIt.I.get<AuthController>().signInUser(
                              context: context,
                              email: email,
                              password: password);
                        }
                      }),
                  const SizedBox(height: 20),
                  NavigationLinkText(
                    text: 'Need an account',
                    clickableText: 'Sing up',
                    navigationRoute: RegisterScreen(),
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
