import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/screens/account_details/account_screen.dart';
import 'package:test_store_app/screens/account_details/order_screen.dart';
import 'package:test_store_app/screens/authentication/otp_screen.dart';
import 'package:test_store_app/screens/authentication/register_screen.dart';
import 'package:test_store_app/screens/authentication/login_screen.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_state_details_provider.dart';
import 'package:test_store_app/screens/cart_screen/cart_screen.dart';
import 'package:test_store_app/screens/cart_screen/checkout_screen.dart';
import 'package:test_store_app/screens/cart_screen/shipping_address_screen.dart';
import 'package:test_store_app/screens/category_screen/screens/category_screen.dart';
import 'package:test_store_app/screens/wishlist/favorite_screen.dart';
import 'package:test_store_app/screens/home_screen/home_screen.dart';
import 'package:test_store_app/screens/navigation/provider/splash_screen_ready_provider.dart';
import 'package:test_store_app/screens/navigation/route_names.dart';
import 'package:test_store_app/screens/navigation/splash_screen.dart';
import 'package:test_store_app/screens/stores/stores_screen.dart';

part 'go_router_provider.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

var _authenticationRoutes = [
  '/${RouteNames.signin}',
  '/${RouteNames.signup}',
  '/${RouteNames.verifyEmail}'
];

bool _isInAuthenticationRoute(String matchedLocation) {
  return _authenticationRoutes.any((element) {
    return matchedLocation.contains(element);
  });
}

bool _isInLoginRestrictedRoutes(String matchedLocation) {
  bool inAuth = _isInAuthenticationRoute(matchedLocation);
  bool notSplashScreen = (matchedLocation != '/${RouteNames.splashScreen}');
  return !inAuth && notSplashScreen;
}

@riverpod
GoRouter router(Ref ref) {
  final isLogin = ref.watch(isLoginProvider);
  return GoRouter(
      navigatorKey: _rootNavigatorKey,
      redirect: (context, state) async {
        String? redirect;
        if (_isInAuthenticationRoute(state.matchedLocation) && isLogin) {
          redirect = '/${RouteNames.home}';
        }

        if (_isInLoginRestrictedRoutes(state.matchedLocation) &&
            isLogin == false) {
          redirect = '/${RouteNames.signin}';
        }
        return redirect;
      },
      initialLocation: '/splashScreen',
      routes: [
        GoRoute(
            redirect: (context, state) {
              String? redirect;
              var splashReady = ref.watch(isSplashScreenReadyProvider);
              if (splashReady) {
                if (isLogin) {
                  redirect = '/home';
                } else {
                  redirect = '/signin';
                }
              }
              return redirect;
            },
            path: '/splashScreen',
            name: RouteNames.splashScreen,
            builder: (context, state) => const SplashScreen()),
        GoRoute(
          path: '/signin',
          name: RouteNames.signin,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
            path: '/signup',
            name: RouteNames.signup,
            builder: (context, state) => const RegisterScreen(),
            routes: [
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: '/verify/:email',
                name: RouteNames.verifyEmail,
                builder: (context, state) {
                  final email = state.pathParameters['email']!;
                  return OtpScreen(registrationEmail: email);
                },
              )
            ]),
        GoRoute(
          path: '/home',
          name: RouteNames.home,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomeScreen()),
        ),
        GoRoute(
          path: '/favourites',
          name: RouteNames.favourites,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: FavoriteScreen()),
        ),
        GoRoute(
          path: '/category',
          name: RouteNames.category,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: CategoryScreen()),
        ),
        GoRoute(
          path: '/${RouteNames.stores}',
          name: RouteNames.stores,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: StoresScreen()),
        ),
        GoRoute(
            path: '/cart',
            name: RouteNames.cart,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: CartScreen()),
            routes: [
              GoRoute(
                  path: '/checout',
                  name: RouteNames.cartCheckout,
                  builder: (context, state) => const CheckoutScreen(),
                  routes: [
                    GoRoute(
                        path: '/shippingAddress',
                        name: RouteNames.cartShippingAddress,
                        builder: (context, state) =>
                            const ShippingAddressScreen())
                  ])
            ]),
        GoRoute(
            path: '/${RouteNames.account}',
            name: RouteNames.account,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: AccountScreen()),
            routes: [
              GoRoute(
                path: '/orders',
                name: RouteNames.accountOrders,
                builder: (context, state) => const OrderScreen(),
              )
            ]),
      ]);
}
