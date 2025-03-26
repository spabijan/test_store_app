import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/models/order/order.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_state_details_provider.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/cart_model.dart';
import 'package:test_store_app/model/services/providers/orders_service_provider.dart';
import 'package:test_store_app/screens/account_details/providers/get_orders_provider.dart';

part 'place_order_provider.g.dart';

@riverpod
class PlaceOrder extends _$PlaceOrder {
  Object? _key;

  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() => _key = null);
  }

  void placeStripeOrder(
      List<CartModel> cart, Map<String, dynamic> intent) async {
    state = const AsyncLoading();
    final key = _key;

    final newState = await AsyncValue.guard(() async {
      await Future.forEach(cart, (product) async {
        final service = ref.read(ordersServiceProvider);
        final user = ref.read(loggedUserProvider)!;
        final loginToken = ref.read(loginTokenProvider)!;
        await service.uploadOrder(
            order: OrderModel.fromStripePayment(user, product, intent),
            loginToken: loginToken);
      });
      // force order provider to redo fetching
      ref.invalidate(ordersProvider);
    });

    if (key == _key) {
      state = newState;
    }
  }

  void placeStripeNotPayedOrder(
      List<CartModel> cart, Map<String, dynamic> intent) async {
    state = const AsyncLoading();
    final key = _key;

    final newState = await AsyncValue.guard(() async {
      await Future.forEach(cart, (product) async {
        final service = ref.read(ordersServiceProvider);
        final user = ref.read(loggedUserProvider)!;
        final loginToken = ref.read(loginTokenProvider)!;
        await service.uploadOrder(
            order: OrderModel.fromStripePayment(user, product, intent),
            loginToken: loginToken);
      });
      // force order provider to redo fetching
      ref.invalidate(ordersProvider);
    });

    if (key == _key) {
      state = newState;
    }
  }

  void placeCashOrder(List<CartModel> cart) async {
    state = const AsyncLoading();
    final key = _key;

    final newState = await AsyncValue.guard(() async {
      await Future.forEach(cart, (product) async {
        final service = ref.read(ordersServiceProvider);
        final user = ref.read(loggedUserProvider)!;
        final token = ref.read(loginTokenProvider)!;
        await service.uploadOrder(
            order: OrderModel.fromCashPayment(user, product),
            loginToken: token);
      });
      // force order provider to redo fetching
      ref.invalidate(ordersProvider);
    });

    if (key == _key) {
      state = newState;
    }
  }
}
