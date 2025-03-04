import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/product_repository.dart';

part 'product_repository_provider.g.dart';

@riverpod
ProductRepository productRepository(Ref ref) {
  return ProductRepository();
}
