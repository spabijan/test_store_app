import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/providers/product_service_provider.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';

part 'top_rated_products_provider.g.dart';

@Riverpod(keepAlive: true)
class TopRatedProducts extends _$TopRatedProducts {
  @override
  FutureOr<List<ProductViewModel>> build() {
    return _loadTopRatedProducts();
  }

  void loadTopRatedProducts() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return _loadTopRatedProducts();
    });
  }

  Future<List<ProductViewModel>> _loadTopRatedProducts() async {
    var products =
        await ref.watch(productServiceProvider).loadTopRatedProducts();
    return [
      for (final category in products) ProductViewModel(productModel: category)
    ];
  }
}
