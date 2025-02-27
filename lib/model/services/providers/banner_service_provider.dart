import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/banner_service.dart';

part 'banner_service_provider.g.dart';

@riverpod
BannerService bannerService(Ref ref) {
  return BannerService();
}
