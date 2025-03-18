import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_review_model.freezed.dart';
part 'product_review_model.g.dart';

@freezed
class ProductReviewModel with _$ProductReviewModel {
  const factory ProductReviewModel(
      {required String buyerId,
      required String email,
      required String fullName,
      required String productId,
      required double rating,
      required String review,
      @JsonKey(name: '_id') @Default('') String id}) = _ProductReviewModel;

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewModelFromJson(json);
}
