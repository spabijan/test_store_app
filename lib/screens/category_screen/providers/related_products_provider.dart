import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/providers/product_service_provider.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';

part 'related_products_provider.g.dart';

@riverpod
class RelatedProducts extends _$RelatedProducts {
  Object? _key;
  late String _productId;

  @override
  FutureOr<List<ProductViewModel>> build(String productId) {
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
    _productId = productId;
    return _loadProducts();
  }

  Future<List<ProductViewModel>> _loadProducts() async {
    var products =
        await ref.watch(productServiceProvider).loadRelatedProducts(_productId);
    return [
      for (final category in products) ProductViewModel(productModel: category)
    ];
  }
}
