import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/controllers/providers/category_item_provider.dart';

class CategoryListItemWidget extends ConsumerWidget {
  const CategoryListItemWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var vm = ref.watch(categoryItemProvider);
    return Column(children: [
      Image.network(vm.image, height: 47, width: 47),
      Text(
        vm.name,
        style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ]);
  }
}

class CategoryItemWidget extends ConsumerWidget {
  const CategoryItemWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var vm = ref.watch(categoryItemProvider);
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(spacing: 8, children: [
          Row(
            children: [
              Text(
                vm.name,
                style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.7),
              ),
              const Spacer()
            ],
          ),
          Container(
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(vm.banner), fit: BoxFit.cover)))
        ]));
  }
}
