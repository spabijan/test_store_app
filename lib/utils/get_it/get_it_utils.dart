import 'package:get_it/get_it.dart';
import 'package:test_store_app/controllers/auth_controller.dart';

final class GetItUtils {
  GetItUtils._();
  static void getitSetup() {
    GetIt getIt = GetIt.instance;
    getIt.registerLazySingleton<AuthController>(AuthController.new);
  }
}
