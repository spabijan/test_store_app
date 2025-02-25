import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/constants/my_colors.dart';
import 'package:test_store_app/views/controllers/providers/signup_provider.dart';
import 'package:test_store_app/r.dart';
import 'package:test_store_app/services/manage_http_response.dart';
import 'package:test_store_app/utils/validation_utils.dart';
import 'package:test_store_app/views/screens/main_screen.dart';
import 'package:test_store_app/views/widgets/authentication_decorated_button.dart';
import 'package:test_store_app/views/widgets/authentication_text_input.dart';
import 'package:test_store_app/views/widgets/navigation_link_text.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  late String email;
  late String fullName;
  late String password;

  Future<void> _registerUser(BuildContext context) async {
    setState(() => _autovalidateMode = AutovalidateMode.always);
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }
    ref
        .read(signupProvider.notifier)
        .signupUser(fullName: fullName, email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(signupProvider, (previous, next) {
      next.whenOrNull(error: (error, stackTrace) {
        if (error is HttpError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.message)));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        }
      });

      next.whenData((value) => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (route) => false,
          ));
    });

    final signinState = ref.watch(signupProvider);

    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.95),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
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
                  Image.asset(AssetImages.illustration,
                      width: 200, height: 200),
                  AuthenticationTextInput(
                      name: 'Email',
                      hintLabel: 'Enter your email',
                      validator: ValidationUtils.emailValidation,
                      onChanged: (value) => email = value),
                  const SizedBox(height: 20),
                  AuthenticationTextInput(
                      onChanged: (text) => fullName = text,
                      name: 'Full Name',
                      hintLabel: 'Enter your full name',
                      validator: (fullName) =>
                          ValidationUtils.textNotEmptyValidation(fullName,
                              emptyMessage: 'Enter your full name')),
                  const SizedBox(height: 16),
                  AuthenticationTextInput(
                      onChanged: (text) => password = text,
                      name: 'Password',
                      hintLabel: 'Enter your password',
                      validator: ValidationUtils.passwordValidation),
                  const SizedBox(height: 24),
                  AuthenticationDecoratedButton(
                      shouldShowLoader: signinState.maybeWhen(
                          loading: () => true, orElse: () => false),
                      text: 'Sign Up',
                      onTapButton: () async {
                        if (_formKey.currentState!.validate()) {
                          _registerUser(context);
                        }
                      }),
                  const SizedBox(height: 20),
                  NavigationLinkText(
                    text: 'Already have an Account',
                    clickableText: 'Sing in',
                    onClick: signinState.maybeWhen(
                        loading: () => null,
                        orElse: () => () => Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                                builder: (_) => const RegisterScreen()))),
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
