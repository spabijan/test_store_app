import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/orders_service.dart';

part 'orders_service_provider.g.dart';

@riverpod
OrdersService ordersService(Ref ref) {
  return OrdersService();
}
