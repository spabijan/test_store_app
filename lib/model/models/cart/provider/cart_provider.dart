import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/models/cart/cart_model.dart';

part 'cart_provider.g.dart';

@Riverpod(keepAlive: true)
class Cart extends _$Cart {
  @override
  Map<String, CartModel> build() {
    return {};
  }

  void addProductToCart(CartModel cartProduct) {
    if (state.containsKey(cartProduct.productId)) {
      state = {
        ...state,
        cartProduct.productId: state[cartProduct.productId]!.copyWith(
            orderQuantity: state[cartProduct.productId]!.orderQuantity +
                cartProduct.orderQuantity)
      };
    } else {
      state = {...state, cartProduct.productId: cartProduct};
    }
  }

  void incrementCartItem(String id) {
    if (state.containsKey(id)) {
      state = state.map((key, value) {
        if (key == id) {
          return MapEntry(
              key, value.copyWith(orderQuantity: value.orderQuantity + 1));
        } else {
          return MapEntry(key, value);
        }
      });
    }
  }

  void decrementCartItem(String id) {
    if (state.containsKey(id)) {
      Map<String, CartModel> newState = {};
      for (final entry in state.entries) {
        if (entry.key != id) {
          newState.addEntries({entry});
        } else {
          if (entry.value.orderQuantity > 1) {
            newState.addEntries({
              MapEntry(
                  entry.key,
                  entry.value
                      .copyWith(orderQuantity: entry.value.orderQuantity - 1))
            });
          }
        }
      }
      state = newState;
    }
  }

  void removeCartItem(String id) {
    if (state.containsKey(id)) {
      Map<String, CartModel> newState = {};
      for (final entry in state.entries) {
        if (entry.key != id) {
          newState.addEntries({entry});
        }
      }
      state = newState;
    }
  }
}
