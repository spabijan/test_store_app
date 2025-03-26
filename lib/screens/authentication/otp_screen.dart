import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/model/services/manage_http_response.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_provider.dart';
import 'package:test_store_app/screens/authentication/widgets/otp_code_widget.dart';
import 'package:test_store_app/screens/cart_screen/widgets/blue_button.dart';
import 'package:test_store_app/screens/navigation/route_names.dart';

class OtpScreen extends ConsumerWidget {
  OtpScreen({
    required this.registrationEmail,
    super.key,
  });

  final String registrationEmail;
  final List<String> otpDigits = List.filled(6, '');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(authProvider, (previous, next) {
      next.whenOrNull(
          data: (_) => GoRouter.of(context).goNamed(RouteNames.home),
          error: (error, _) => error is HttpError
              ? ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(error.message)))
              : ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(error.toString()))));
    });
    final authState = ref.watch(authProvider);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Verify your account',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  )),
              const SizedBox(height: 10),
              Text('Enter the OTP sent to $registrationEmail',
                  style: GoogleFonts.lato()),
              const SizedBox(height: 16),
              OtpCodeWidget(onChange: (index, char) => otpDigits[index] = char),
              const SizedBox(height: 32),
              authState.maybeMap(
                  loading: (loading) =>
                      const Center(child: CircularProgressIndicator.adaptive()),
                  orElse: () => BlueButton(
                        textButton: 'Verify code',
                        onTap: () {
                          if (otpDigits.contains('')) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Fields cannot be empty')));
                            return;
                          }
                          ref.read(authProvider.notifier).verifyOtp(
                              email: registrationEmail,
                              otp: otpDigits.fold(
                                  '',
                                  (previousValue, element) =>
                                      previousValue + element));
                        },
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
