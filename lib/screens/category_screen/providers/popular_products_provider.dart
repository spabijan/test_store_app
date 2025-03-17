import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/providers/product_repository_provider.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';

part 'popular_products_provider.g.dart';

@Riverpod(keepAlive: true)
class PopularProducts extends _$PopularProducts {
  @override
  FutureOr<List<ProductViewModel>> build() {
    return _loadPopularProducts();
  }

  void loadPopularProducts() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return _loadPopularProducts();
    });
  }

  Future<List<ProductViewModel>> _loadPopularProducts() async {
    var products =
        await ref.watch(productRepositoryProvider).loadPopularProducts();
    return [
      for (final category in products) ProductViewModel(productModel: category)
    ];
  }
}
