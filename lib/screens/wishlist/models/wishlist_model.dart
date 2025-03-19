import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:decimal/decimal.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';

part 'wishlist_model.freezed.dart';
part 'wishlist_model.g.dart';

@freezed
class WishlistModel with _$WishlistModel {
  const factory WishlistModel(
      {required String productName,
      required Decimal productPrice,
      required String category,
      required List<String> image,
      required String vendorID,
      required String productId,
      required String description,
      required String vendorFullName}) = _WishlistModel;

  factory WishlistModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistModelFromJson(json);

  factory WishlistModel.fromProduct(ProductViewModel product) => WishlistModel(
      productName: product.productName,
      productPrice: product.productPrice,
      category: product.category,
      image: product.images,
      vendorID: product.vendorId,
      productId: product.productId,
      description: product.description,
      vendorFullName: product.vendorFullName);
}
