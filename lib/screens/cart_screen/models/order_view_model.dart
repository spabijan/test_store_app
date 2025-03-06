import 'package:test_store_app/model/models/order/order.dart';

class OrderViewModel {
  OrderViewModel({required OrderModel orderModel}) : _orderModel = orderModel;

  final OrderModel _orderModel;
}
