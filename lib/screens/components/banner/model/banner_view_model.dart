import 'package:test_store_app/model/models/baner/baner_model.dart';

class BannerViewModel {
  BannerViewModel({required BannerModel bannerModel})
      : _bannerModel = bannerModel;
  final BannerModel _bannerModel;

  String get image => _bannerModel.image;
}
