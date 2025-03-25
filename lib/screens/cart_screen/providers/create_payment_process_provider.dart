import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/providers/orders_service_provider.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_state_details_provider.dart';

part 'create_payment_process_provider.g.dart';

@riverpod
class CreatePaymentProcess extends _$CreatePaymentProcess {
  Object? _key;

  @override
  FutureOr<Map<String, dynamic>> build() {
    _key = Object();
    ref.onDispose(() => _key = null);
    return {};
  }

  void createPaymentIntend(
      {required int amount, required String currency}) async {
    state = const AsyncLoading();
    final key = _key;
    final newState = await AsyncValue.guard(() async {
      final token = ref.read(loginTokenProvider)!;
      final service = ref.read(ordersServiceProvider);
      return await service.createPaymentIntent(
          amount: amount, currency: currency, loginToken: token);
    });

    if (key == _key) {
      state = newState;
    }
  }
}
