import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/services/vendor_services.dart';

part 'vendors_service_provider.g.dart';

@riverpod
VendorServices vendorService(Ref ref) {
  return VendorServices();
}
