import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payment_satatus_provider.g.dart';

@riverpod
class PaymentSatatus extends _$PaymentSatatus {
  Object? _key;
  late String _intentId;
  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() => _key = null);
  }

  void getPaymentIntent() {}
}
