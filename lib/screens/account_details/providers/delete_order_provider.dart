
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/providers/orders_service_provider.dart';
import 'package:test_store_app/screens/account_details/providers/get_orders_provider.dart';

part 'delete_order_provider.g.dart';

@riverpod
class DeleteOrder extends _$DeleteOrder {
  Object? _key;
  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() => _key = null);
  }

  void deleteOrder(String orderId) async {
    state = const AsyncLoading();
    final key = _key;

    final newState = await AsyncValue.guard(() async {
      final service = ref.read(ordersServiceProvider);
      await service.deleteOrderById(orderId: orderId);
      ref.invalidate(ordersProvider);
    });

    if (key == _key) {
      state = newState;
    }
  }
}
