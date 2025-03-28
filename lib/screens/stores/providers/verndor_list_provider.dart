import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/model/models/vendor_model.dart';
import 'package:test_store_app/model/services/providers/vendors_service_provider.dart';

part 'verndor_list_provider.g.dart';

@riverpod
class VendorList extends _$VendorList {
  @override
  FutureOr<List<VendorModel>> build() {
    return ref.watch(vendorServiceProvider).getVendors();
  }
}
