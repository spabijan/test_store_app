import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/cart_model.dart';
import 'package:test_store_app/screens/components/cart/model/provider/cart_repository_provider.dart';

part 'cart_provider.g.dart';

@Riverpod(keepAlive: true)
class Cart extends _$Cart {
  @override
  FutureOr<List<CartModel>> build() {
    return _getCartItems();
  }

  Future<List<CartModel>> _getCartItems() async {
    return await ref.read(cartRepositoryProvider).getCartItems();
  }

  void addProductToCart(CartModel cartProduct) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final data = state.value!;

      if (data.any((element) => element.productId == cartProduct.productId)) {
        var foundDuplicate = data.firstWhere(
            (element) => element.productId == cartProduct.productId);
        var newValue = foundDuplicate.copyWith(
            orderQuantity:
                foundDuplicate.orderQuantity + cartProduct.orderQuantity);

        ref.read(cartRepositoryProvider).addToCart(model: newValue);
        return [
          for (final product in data)
            product.productId == cartProduct.productId ? newValue : product
        ];
      } else {
        ref.read(cartRepositoryProvider).addToCart(model: cartProduct);
        return [...data, cartProduct];
      }
    });
  }

  void incrementCartItem(String id) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final data = state.value!;
      var foundDuplicate =
          data.firstWhere((element) => element.productId == id);
      var newValue = foundDuplicate.copyWith(
          orderQuantity: foundDuplicate.orderQuantity + 1);
      ref.read(cartRepositoryProvider).addToCart(model: newValue);
      return [
        for (final product in data) product.productId == id ? newValue : product
      ];
    });
  }

  void decrementCartItem(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final data = state.value!;
      var foundDuplicate =
          data.firstWhere((element) => element.productId == id);

      if (foundDuplicate.orderQuantity <= 1) {
        ref.read(cartRepositoryProvider).removeFromCart(id: id);
        return [
          for (final elem in data)
            if (elem.productId != id) elem
        ];
      } else {
        var newValue = foundDuplicate.copyWith(
            orderQuantity: foundDuplicate.orderQuantity - 1);
        ref.read(cartRepositoryProvider).addToCart(model: newValue);

        return [
          for (final product in data)
            product.productId == id ? newValue : product
        ];
      }
    });
  }

  void removeCartItem(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final data = state.value!;
      ref.read(cartRepositoryProvider).removeFromCart(id: id);
      return [
        for (final elem in data)
          if (elem.productId != id) elem
      ];
    });
  }

  void clearCart() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final data = state.value!;
      ref.read(cartRepositoryProvider).clearCart();
      return [];
    });
  }
}
