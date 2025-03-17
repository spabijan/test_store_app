import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/providers/product_repository_provider.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';

part 'popular_products_provider.g.dart';

@Riverpod(keepAlive: true)
class PopularProducts extends _$PopularProducts {
  Object? _key;
  @override
  FutureOr<List<ProductViewModel>> build() {
    _key = Object();
    ref.onDispose(() => _key = null);
    return _loadPopularProducts();
  }

  void loadPopularProducts() async {
    state = const AsyncLoading();
    final key = _key;

    final newState = await AsyncValue.guard(() async {
      return _loadPopularProducts();
    });

    if (key == _key) {
      state = newState;
    }
  }

  Future<List<ProductViewModel>> _loadPopularProducts() async {
    var products =
        await ref.read(productRepositoryProvider).loadPopularProducts();
    return [
      for (final category in products) ProductViewModel(productModel: category)
    ];
  }
}
