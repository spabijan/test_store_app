import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/screens/account_details/providers/get_orders_provider.dart';

part 'order_count_provider.g.dart';

// util provider to simplify counting user order
@riverpod
int orderCount(Ref ref) {
  final orders = ref.watch(ordersProvider);
  return orders.maybeWhen(orElse: () => 0, data: (data) => data.length);
}
