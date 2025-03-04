import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/screens/account_screen.dart';
import 'package:test_store_app/screens/authentication/create_account/register_screen.dart';
import 'package:test_store_app/screens/authentication/login/login_screen.dart';
import 'package:test_store_app/screens/authentication/repository/providers/token_repository_provider.dart';
import 'package:test_store_app/screens/cart_screen.dart';
import 'package:test_store_app/screens/category_screen/category_screen.dart';
import 'package:test_store_app/screens/category_screen/inner_category_screen.dart';
import 'package:test_store_app/screens/category_screen/product_detial_screen.dart';
import 'package:test_store_app/screens/favorite_screen.dart';
import 'package:test_store_app/screens/home_screen.dart';
import 'package:test_store_app/screens/navigation/route_names.dart';
import 'package:test_store_app/screens/stores_screen.dart';

part 'go_router_provider.g.dart';

var _authenticationRoutes = ['/${RouteNames.signin}', '/${RouteNames.signup}'];

bool _isInAuthenticationRoute(String matchedLocation) {
  return _authenticationRoutes.contains(matchedLocation);
}

bool _hasLoginToken(String? token) => token != null && token.isNotEmpty;

@riverpod
GoRouter router(Ref ref) {
  //final authState = ref.watch(authStateProvider);
  return GoRouter(
      redirect: (context, state) async {
        //this is not reactive solution
        //- for fully reactive check my test_vendor_app
        final token = await ref.read(tokenRepositoryProvider).getToken();
        final isInAuthenticationRoute =
            _isInAuthenticationRoute(state.matchedLocation);

        if (isInAuthenticationRoute && _hasLoginToken(token)) {
          return '/${RouteNames.home}';
        }
        if (!isInAuthenticationRoute && !_hasLoginToken(token)) {
          return '/${RouteNames.signin}';
        }
        return null;
      },
      initialLocation: '/${RouteNames.signin}',
      routes: [
        GoRoute(
          path: '/${RouteNames.signin}',
          name: RouteNames.signin,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/${RouteNames.signup}',
          name: RouteNames.signup,
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/${RouteNames.home}',
          name: RouteNames.home,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomeScreen()),
        ),
        GoRoute(
          path: '/${RouteNames.favourites}',
          name: RouteNames.favourites,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: FavoriteScreen()),
        ),
        GoRoute(
          path: '/${RouteNames.category}',
          name: RouteNames.category,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: CategoryScreen()),
          routes: [
            GoRoute(
                path: '/${RouteNames.categoryDetails}',
                name: RouteNames.categoryDetails,
                builder: (context, state) => const InnerCategoryScreen(),
                routes: [
                  GoRoute(
                    path: '/${RouteNames.productDetails}',
                    name: RouteNames.productDetails,
                    builder: (_, __) => const ProductDetailScreen(),
                  )
                ])
          ],
        ),
        GoRoute(
          path: '/${RouteNames.stores}',
          name: RouteNames.stores,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: StoresScreen()),
        ),
        GoRoute(
          path: '/${RouteNames.cart}',
          name: RouteNames.cart,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: CartScreen()),
        ),
        GoRoute(
          path: '/${RouteNames.account}',
          name: RouteNames.account,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: AccountScreen()),
        ),
      ]);
}
