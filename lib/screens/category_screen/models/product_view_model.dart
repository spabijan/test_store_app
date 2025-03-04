import 'package:test_store_app/model/models/product/product.dart';

class ProductViewModel {
  ProductViewModel({required ProductModel productModel})
      : _productModel = productModel;

  final ProductModel _productModel;
  String get productName => _productModel.productName;
  double get productPrice => _productModel.productPrice;
  double get quantity => _productModel.quantity;
  String get description => _productModel.description;
  String get category => _productModel.category;
  String get subcategory => _productModel.subcategory;
  List<String> get images => _productModel.images;
}
