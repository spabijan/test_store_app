import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/services/providers/subcategory_service_provider.dart';
import 'package:test_store_app/views/model/subcategory_view_model.dart';

part 'subcategories_provider.g.dart';

@riverpod
class Subcategories extends _$Subcategories {
  Object? _key;
  late String _categoryName;
  @override
  FutureOr<List<SubcategoryViewModel>> build(String categoryName) {
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
    return List.empty();
  }

  void loadSubcategories() async {
    state = const AsyncLoading();
    final key = _key;

    final newState = await AsyncValue.guard(() async {
      var categories = await ref
          .read(subcategoryServiceProvider)
          .loadSubcategoriesByName(_categoryName);
      return [
        for (final category in categories)
          SubcategoryViewModel(subcategoryModel: category)
      ];
    });

    if (key == _key) {
      state = newState;
    }
  }
}
