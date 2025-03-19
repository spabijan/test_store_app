import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/screens/cart_screen/constants/payment_types.dart';
import 'package:test_store_app/screens/cart_screen/providers/selected_payment_method_provider.dart';

class PaymentSelectionWidget extends ConsumerWidget {
  const PaymentSelectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        for (final type in PaymentTypes.values) PaymentMethodRow(type: type),
      ],
    );
  }
}

class PaymentMethodRow extends ConsumerWidget {
  const PaymentMethodRow({required this.type, super.key});

  final PaymentTypes type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentMethod = ref.watch(selectedPaymentMethodProvider);

    return RadioListTile<PaymentTypes>(
        title: Text(type.title,
            style: GoogleFonts.montserrat(
                fontSize: 18, fontWeight: FontWeight.bold)),
        value: type,
        groupValue: paymentMethod,
        onChanged: (newValue) =>
            ref.read(selectedPaymentMethodProvider.notifier).state = newValue!);
  }
}
