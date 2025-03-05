import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/screens/category_screen/models/category_view_model.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';

final selectedCategoryProvider = StateProvider<CategoryViewModel?>((ref) {
  return null;
});

final selectedProductProvider = StateProvider<ProductViewModel?>((ref) {
  return;
});
