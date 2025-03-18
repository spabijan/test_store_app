import 'package:test_store_app/model/models/order/order.dart';

class OrderViewModel {
  OrderViewModel({required OrderModel orderModel}) : _orderModel = orderModel;

  final OrderModel _orderModel;

  String get id => _orderModel.id;
  String get fullName => _orderModel.fullName;
  String get email => _orderModel.email;
  String get productName => _orderModel.productName;
  double get productPrice => _orderModel.productPrice;
  int get quantity => _orderModel.quantity;
  String get category => _orderModel.category;
  String get image => _orderModel.image;
  String get buyerId => _orderModel.buyerId;
  String get vendorId => _orderModel.vendorId;
  String get city => _orderModel.city;
  String get state => _orderModel.state;
  String get locality => _orderModel.locality;
  bool get processing => _orderModel.processing ?? false;
  bool get delivered => _orderModel.delivered ?? false;
}
