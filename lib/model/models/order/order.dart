import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_store_app/model/models/user/user.dart';
import 'package:test_store_app/screens/cart_screen/models/cart/cart_model.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class OrderModel with _$OrderModel {
  const factory OrderModel(
      {required String fullName,
      required String email,
      required String productName,
      required double productPrice,
      required int quantity,
      required String category,
      required String image,
      required String buyerId,
      required String vendorId,
      required String city,
      required String state,
      required String locality,
      required String paymentStatus,
      required String paymentIntent,
      required String paymentMethod,
      bool? processing,
      bool? delivered,
      @JsonKey(name: '_id') @Default('') String id}) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  factory OrderModel.fromStripePayment(
      User user, CartModel product, Map<String, dynamic> intent) {
    return OrderModel(
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
        locality: user.locality,
        paymentIntent: intent['id'],
        paymentMethod: 'card',
        paymentStatus: intent['status']);
  }

  factory OrderModel.fromCashPayment(User user, CartModel product) {
    return OrderModel(
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
        locality: user.locality,
        paymentIntent: 'cash on',
        paymentMethod: 'cash on delivery',
        paymentStatus: 'on delivery');
  }
}
