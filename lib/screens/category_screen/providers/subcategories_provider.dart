import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/providers/subcategory_service_provider.dart';
import 'package:test_store_app/screens/category_screen/models/subcategory_view_model.dart';

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
    return _loadSubcategories();
  }

  Future<List<SubcategoryViewModel>> _loadSubcategories() async {
    var categories = await ref
        .watch(subcategoryServiceProvider)
        .loadSubcategoriesByName(_categoryName);
    return [
      for (final category in categories)
        SubcategoryViewModel(subcategoryModel: category)
    ];
  }
}
