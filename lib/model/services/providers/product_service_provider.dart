import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/product_services.dart';

part 'product_service_provider.g.dart';

@riverpod
ProductServices productService(Ref ref) {
  return ProductServices();
}
