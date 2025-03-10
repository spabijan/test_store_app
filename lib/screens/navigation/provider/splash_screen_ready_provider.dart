import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_provider.dart';

part 'splash_screen_ready_provider.g.dart';

@Riverpod(keepAlive: true)
bool isSplashScreenReady(Ref ref) {
  // check only for finished reading from local data
  final restoredSessionState = ref.watch(authProvider);

  return restoredSessionState.hasValue;
}
