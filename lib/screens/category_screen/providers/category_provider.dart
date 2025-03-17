import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/providers/category_service_provider.dart';
import 'package:test_store_app/screens/category_screen/models/category_view_model.dart';

part 'category_provider.g.dart';

@Riverpod(keepAlive: true)
class Categories extends _$Categories {
  @override
  FutureOr<List<CategoryViewModel>> build() {
    return _loadCategories();
  }

  void loadCategories() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return _loadCategories();
    });
  }

  Future<List<CategoryViewModel>> _loadCategories() async {
    var categories = await ref.watch(categoryServiceProvider).loadCategories();
    return [
      for (final category in categories)
        CategoryViewModel(categoryModel: category)
    ];
  }
}
