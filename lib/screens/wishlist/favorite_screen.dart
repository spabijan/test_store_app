import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/screens/cart_screen/widgets/cart_info_icon.dart';
import 'package:test_store_app/screens/navigation/navigation_tapbar.dart';
import 'package:test_store_app/screens/wishlist/providers/wishlist_list_item_provider.dart';
import 'package:test_store_app/screens/wishlist/providers/wishlist_provider.dart';
import 'package:test_store_app/screens/wishlist/widgets/wishlist_list_tile_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
          child: Consumer(
            builder: (_, WidgetRef ref, __) {
              final items = ref.watch(wishlistItemCountProvider);
              return AppBarWidget(
                text: 'My Favorites',
                itemCount: items,
              );
            },
          ),
        ),
        bottomNavigationBar: NavigationTapBar(),
        body: Consumer(
          builder: (_, WidgetRef ref, __) {
            final wishlist = ref.watch(wishlistProvider);
            return wishlist.isEmpty
                ? Center(
                    child: Text('Your wishlist is empty',
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade900)))
                : ListView.builder(
                    itemCount: wishlist.length,
                    itemBuilder: (context, index) {
                      return ProviderScope(overrides: [
                        wishlistListItemProvider
                            .overrideWithValue(wishlist.values.toList()[index])
                      ], child: const WishlistListTileItem());
                    },
                  );
          },
        ));
  }
}
