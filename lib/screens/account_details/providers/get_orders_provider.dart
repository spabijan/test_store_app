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
      var orders =
          await ref.watch(ordersServiceProvider).getOrderById(buyerID: userID);
      return [for (final order in orders) OrderViewModel(orderModel: order)];
    } else {
      return List.empty();
    }
  }
}
