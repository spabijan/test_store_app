enum PaymentTypes {
  stripe(title: 'Stripe', checkoutMessage: 'Proceed to payment'),
  cash(title: 'Cash on delivery', checkoutMessage: 'Place Order');

  const PaymentTypes({required this.title, required this.checkoutMessage});

  final String title;
  final String checkoutMessage;
}
