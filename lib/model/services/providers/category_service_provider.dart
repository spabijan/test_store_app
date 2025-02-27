import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/category_service.dart';

part 'category_service_provider.g.dart';

@riverpod
CategoryService categoryService(Ref ref) {
  return CategoryService();
}
