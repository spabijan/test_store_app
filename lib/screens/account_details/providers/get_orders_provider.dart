import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/providers/orders_service_provider.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_state_details_provider.dart';
import 'package:test_store_app/screens/category_screen/models/order_view_model.dart';

part 'get_orders_provider.g.dart';

@Riverpod(keepAlive: true)
class Orders extends _$Orders {
  @override
  FutureOr<List<OrderViewModel>> build() {
    return _loadUserOrders();
  }

  void loadUserOrders() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return _loadUserOrders();
    });
  }

  Future<List<OrderViewModel>> _loadUserOrders() async {
    final userID = ref.watch(loggedUserProvider)?.id;
    if (userID != null) {
      final token = ref.read(loginTokenProvider);
      var orders = await ref
          .read(ordersServiceProvider)
          .getOrderById(buyerID: userID, loginToken: token!);
      return [for (final order in orders) OrderViewModel(orderModel: order)];
    } else {
      return List.empty();
    }
  }
}

@riverpod
int ordersCompleted(Ref ref) {
  return ref.watch(ordersProvider).maybeWhen(
      orElse: () => 0,
      data: (data) => data.fold(
          0,
          (previousValue, element) =>
              previousValue + (element.delivered ? 1 : 0)));
}
