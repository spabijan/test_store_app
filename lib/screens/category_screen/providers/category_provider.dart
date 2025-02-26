import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/services/providers/category_service_provider.dart';
import 'package:test_store_app/views/model/category_view_model.dart';

part 'category_provider.g.dart';

@Riverpod(keepAlive: true)
class Categories extends _$Categories {
  Object? _key;

  @override
  FutureOr<List<CategoryViewModel>> build() {
    _key = Object();
    ref.onDispose(() => _key = null);
    return List.empty();
  }

  void loadCategories() async {
    state = const AsyncLoading();
    final key = _key;

    final newState = await AsyncValue.guard(() async {
      var categories = await ref.read(categoryServiceProvider).loadCategories();
      return [
        for (final category in categories)
          CategoryViewModel(categoryModel: category)
      ];
    });

    if (key == _key) {
      state = newState;
    }
  }
}
