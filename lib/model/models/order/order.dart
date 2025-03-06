import 'package:freezed_annotation/freezed_annotation.dart';

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
      bool? processing,
      bool? delivered,
      @JsonKey(name: '_id') @Default('') String id}) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
