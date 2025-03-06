import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
class CartModel with _$CartModel {
  const factory CartModel(
      {required String productName,
      required Decimal productPrice,
      required String category,
      required List<String> image,
      required String vendorID,
      required int stockQuantity,
      required int orderQuantity,
      required String productId,
      required String description,
      required String vendorFullName}) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
}
