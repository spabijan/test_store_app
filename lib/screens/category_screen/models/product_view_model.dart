import 'package:test_store_app/model/models/product/product.dart';

class ProductViewModel {
  ProductViewModel({required ProductModel productModel})
      : _productModel = productModel;

  final ProductModel _productModel;
  String get productName => _productModel.productName;
  double get productPrice => _productModel.productPrice;
  int get quantity => _productModel.quantity.floor();
  String get description => _productModel.description;
  String get category => _productModel.category;
  String get subcategory => _productModel.subcategory;
  List<String> get images => _productModel.images;
  String get vendorId => _productModel.vendorId;
  String get productId => _productModel.id;
  String get vendorFullName => _productModel.vendorFullName;
  bool get hasReviews => _productModel.totalRating > 0;
  int get totalRatings => _productModel.totalRating;
  double get averageRating => _productModel.averageRating;
}
