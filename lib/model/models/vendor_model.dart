import 'package:freezed_annotation/freezed_annotation.dart';

part 'vendor_model.g.dart';
part 'vendor_model.freezed.dart';

@freezed
class VendorModel with _$VendorModel {
  const factory VendorModel(
      {required String fullName,
      required String email,
      @JsonKey(name: '_id') @Default('') String id,
      @Default('') String state,
      @Default('') String locality,
      @Default('') String role,
      @JsonKey(name: 'storeImage') @Default('') String storeImageUrl,
      @Default('') String storeDescription,
      @Default('') String token}) = _VendorModel;

  factory VendorModel.fromJson(Map<String, dynamic> json) =>
      _$VendorModelFromJson(json);
}
