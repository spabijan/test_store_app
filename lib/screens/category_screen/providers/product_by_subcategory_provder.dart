import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/providers/product_service_provider.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';

part 'product_by_subcategory_provder.g.dart';

@riverpod
class ProductBySubcategory extends _$ProductBySubcategory {
  Object? _key;
  late String _subcategoryName;
  @override
  FutureOr<List<ProductViewModel>> build(String subcategoryName) {
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
    _subcategoryName = subcategoryName;
    return _loadProducts();
  }

  void loadProducts() async {
    state = const AsyncLoading();
    final key = _key;

    final newState = await AsyncValue.guard(() async {
      return _loadProducts();
    });

    if (key == _key) {
      state = newState;
    }
  }

  Future<List<ProductViewModel>> _loadProducts() async {
    var products = await ref
        .read(productServiceProvider)
        .loadProductBySubcategory(_subcategoryName);
    return [
      for (final category in products) ProductViewModel(productModel: category)
    ];
  }
}
