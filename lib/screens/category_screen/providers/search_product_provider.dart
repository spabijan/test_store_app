import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/providers/product_service_provider.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';

part 'search_product_provider.g.dart';

@riverpod
class SearchProduct extends _$SearchProduct {
  late String _query;

  @override
  FutureOr<List<ProductViewModel>> build({required String query}) {
    return _searchQuery();
  }

  Future<List<ProductViewModel>> _searchQuery() async {
    var products =
        await ref.watch(productServiceProvider).searchProduct(query: _query);
    return [
      for (final category in products) ProductViewModel(productModel: category)
    ];
  }
}
