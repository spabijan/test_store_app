import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/providers/product_reviews_service_provider.dart';

part 'post_review_provider.g.dart';

@riverpod
class PostReview extends _$PostReview {
  Object? _key;

  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() => _key = null);
  }

  void placeReview(
      {required String buyerId,
      required String email,
      required String fullName,
      required String productId,
      required double rating,
      required String review}) async {
    state = const AsyncLoading();
    final key = _key;

    final newState = await AsyncValue.guard(
      () async {
        final service = ref.read(reviewsServiceProvider);
        await service.addReview(
            buyerId: buyerId,
            email: email,
            fullName: fullName,
            productId: productId,
            rating: rating,
            review: review);
      },
    );
    if (key == _key) {
      state = newState;
    }
  }
}
