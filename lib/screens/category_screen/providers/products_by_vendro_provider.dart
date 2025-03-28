import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/providers/product_service_provider.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_state_details_provider.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';

part 'products_by_vendro_provider.g.dart';

@riverpod
class ProductsByVendors extends _$ProductsByVendors {
  late String _vendorId;

  @override
  FutureOr<List<ProductViewModel>> build(String vendorId) {
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

    _vendorId = vendorId;
    return _loadProducts();
  }

  Future<List<ProductViewModel>> _loadProducts() async {
    var loginToken = ref.watch(loginTokenProvider);
    var products = await ref
        .watch(productServiceProvider)
        .loadVendorProducts(vendorId: _vendorId, token: loginToken);
    return [
      for (final category in products) ProductViewModel(productModel: category)
    ];
  }
}

@riverpod
int vendorProductCounter(Ref ref, String vendorId) {
  return ref
      .watch(productsByVendorsProvider(vendorId))
      .maybeWhen(data: (data) => data.length, orElse: () => 0);
}
