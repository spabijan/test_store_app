import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/constants/my_colors.dart';
import 'package:test_store_app/screens/authentication/login/providers/signin_provider.dart';
import 'package:test_store_app/r.dart';
import 'package:test_store_app/screens/navigation/route_names.dart';
import 'package:test_store_app/services/manage_http_response.dart';
import 'package:test_store_app/services/utils/validation_utils.dart';
import 'package:test_store_app/screens/authentication/create_account/register_screen.dart';
import 'package:test_store_app/screens/authentication/widgets/authentication_decorated_button.dart';
import 'package:test_store_app/screens/authentication/widgets/authentication_text_input.dart';
import 'package:test_store_app/screens/widgets/navigation_link_text.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  late String email;
  late String password;

  Future<void> _loginUser() async {
    setState(() => _autovalidateMode = AutovalidateMode.always);
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }

    ref
        .read(signinProvider.notifier)
        .signinUser(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(signinProvider, (previous, next) {
      next.whenOrNull(error: (error, stackTrace) {
        if (error is HttpError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.message)));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        }
      });
      next.whenData((value) => GoRouter.of(context).goNamed(RouteNames.home));
    });

    final signinState = ref.watch(signinProvider);

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
                      shouldShowLoader: signinState.maybeWhen(
                          loading: () => true, orElse: () => false),
                      text: 'Sign In',
                      onTapButton: () {
                        if (_formKey.currentState!.validate()) {
                          _loginUser();
                        }
                      }),
                  const SizedBox(height: 20),
                  NavigationLinkText(
                    text: 'Need an account',
                    clickableText: 'Sing up',
                    onClick: signinState.maybeWhen(
                      loading: () => null,
                      orElse: () => () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (_) => const RegisterScreen())),
                    ),
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
