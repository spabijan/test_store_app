import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/services/providers/banner_service_provider.dart';
import 'package:test_store_app/views/model/banner_view_model.dart';

part 'banner_provider.g.dart';

@Riverpod(keepAlive: true)
class Banners extends _$Banners {
  Object? _key;

  @override
  FutureOr<List<BannerViewModel>> build() {
    _key = Object();
    ref.onDispose(() => _key = null);
    return List.empty();
  }

  void loadBanner() async {
    state = const AsyncLoading();
    final key = _key;

    final newState = await AsyncValue.guard(() async {
      var banners = await ref.read(bannerServiceProvider).loadBanners();
      return [
        for (final banner in banners) BannerViewModel(bannerModel: banner)
      ];
    });

    if (key == _key) {
      state = newState;
    }
  }
}
