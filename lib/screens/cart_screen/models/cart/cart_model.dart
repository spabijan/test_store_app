import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
class CartModel with _$CartModel {
  const factory CartModel(
      {required String productName,
      required double productPrice,
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

  factory CartModel.fromProduct(ProductViewModel product) => CartModel(
      productName: product.productName,
      productPrice: product.productPrice,
      category: product.category,
      image: product.images,
      vendorID: product.vendorId,
      stockQuantity: product.quantity,
      orderQuantity: 1,
      productId: product.productId,
      description: product.description,
      vendorFullName: product.vendorFullName);
}
