import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/providers/product_service_provider.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';

part 'products_by_category_provider.g.dart';

@riverpod
class ProductsByCategory extends _$ProductsByCategory {
  Object? _key;
  late String _categoryName;

  @override
  FutureOr<List<ProductViewModel>> build(String categoryName) {
    /** 
      custom lifecycle - provider will dispose one minute after
      the last listener unsubscribe
    */
    final keepAliveLink = ref.keepAlive();
    Timer? timer;
    ref.onCancel(() {
      timer = Timer(
        const Duration(minutes: 1),
        keepAliveLink.close,
      );
    });
    ref.onResume(() {
      timer?.cancel();
    });

    _key = Object();
    _categoryName = categoryName;
    return _loadProducts();
  }

  Future<List<ProductViewModel>> _loadProducts() async {
    var products = await ref
        .watch(productServiceProvider)
        .loadProductsByCategory(_categoryName);
    return [
      for (final category in products) ProductViewModel(productModel: category)
    ];
  }
}
