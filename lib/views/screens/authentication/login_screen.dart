import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/constants/my_colors.dart';
import 'package:test_store_app/controllers/auth_controller.dart';
import 'package:test_store_app/r.dart';
import 'package:test_store_app/utils/validation_utils.dart';
import 'package:test_store_app/views/screens/authentication/register_screen.dart';
import 'package:test_store_app/views/screens/main_screen.dart';
import 'package:test_store_app/views/widgets/authentication_decorated_button.dart';
import 'package:test_store_app/views/widgets/authentication_text_input.dart';
import 'package:test_store_app/views/widgets/navigation_link_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;

  late String password;

  bool _isLoading = false;

  Future<void> _loginUser(BuildContext context) async {
    setState(() => _isLoading = true);
    final result = await GetIt.I
        .get<AuthController>()
        .signInUser(context: context, email: email, password: password);
    setState(() => _isLoading = false);
    if (result == AuthControllerResult.success && context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const MainScreen()),
          (route) => false);
    }
  }

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
                  Image.asset(AssetImages.illustration,
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
                      shouldShowLoader: _isLoading,
                      text: 'Sign In',
                      onTapButton: () {
                        if (_formKey.currentState!.validate()) {
                          _loginUser(context);
                        }
                      }),
                  const SizedBox(height: 20),
                  const NavigationLinkText(
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
