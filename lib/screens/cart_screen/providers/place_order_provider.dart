import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_state_details_provider.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/cart_model.dart';
import 'package:test_store_app/model/services/providers/orders_service_provider.dart';

part 'place_order_provider.g.dart';

@riverpod
class PlaceOrder extends _$PlaceOrder {
  Object? _key;

  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() => _key = null);
  }

  void placeOrder(List<CartModel> cart) async {
    state = const AsyncLoading();
    final service = ref.watch(ordersServiceProvider);
    final user = ref.watch(loggedUserProvider)!;
    final key = _key;

    final newState = await AsyncValue.guard(() async {
      await Future.forEach(cart, (product) {
        service.uploadOrder(
            fullName: user.fullName,
            email: user.email,
            productName: product.productName,
            productPrice: product.productPrice.toDouble(),
            quantity: product.orderQuantity,
            category: product.category,
            image: product.image.first,
            buyerId: user.id,
            vendorId: product.vendorID,
            city: user.city,
            state: user.state,
            locality: user.locality);
      });
    });

    if (key == _key) {
      state = newState;
    }
  }
}
