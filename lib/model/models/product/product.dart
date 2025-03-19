import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel(
      {required String productName,
      required double productPrice,
      required double quantity,
      required String description,
      required String category,
      required String subcategory,
      required List<String> images,
      required String vendorId,
      @JsonKey(name: 'fullName') required String vendorFullName,
      @Default(0.0) double averageRating,
      @Default(0) int totalRating,
      @JsonKey(name: '_id') @Default('') String id}) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
