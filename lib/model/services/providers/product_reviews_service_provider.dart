import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/product_reviews_service.dart';

part 'product_reviews_service_provider.g.dart';

@riverpod
ProductReviewsService reviewsService(Ref ref) {
  return ProductReviewsService();
}
