import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/providers/banner_service_provider.dart';
import 'package:test_store_app/screens/components/banner/model/banner_view_model.dart';

part 'banner_provider.g.dart';

@Riverpod(keepAlive: true)
class Banners extends _$Banners {
  @override
  FutureOr<List<BannerViewModel>> build() {
    return _loadBanners();
  }

  void loadBanner() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return _loadBanners();
    });
  }

  FutureOr<List<BannerViewModel>> _loadBanners() async {
    var banners = await ref.read(bannerServiceProvider).loadBanners();
    return [for (final banner in banners) BannerViewModel(bannerModel: banner)];
  }
}
