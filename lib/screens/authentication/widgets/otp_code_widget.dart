import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpCodeWidget extends StatelessWidget {
  const OtpCodeWidget({required this.onChange, super.key});

  final void Function(int index, String char) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            6,
            (index) => _buildOtpField(index, context),
          )),
    );
  }

  Widget _buildOtpField(int index, BuildContext context) {
    return SizedBox(
      width: 48,
      height: 55,
      child: TextField(
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        onChanged: (String change) {
          onChange(index, change);
          if (index < 5) {
            FocusScope.of(context).nextFocus();
          }
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style:
            GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            )),
      ),
    );
  }
}
