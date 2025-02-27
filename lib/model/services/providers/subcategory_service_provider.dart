import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/services/subcategory_service.dart';

part 'subcategory_service_provider.g.dart';

@riverpod
SubcategoryService subcategoryService(Ref ref) {
  return SubcategoryService();
}
