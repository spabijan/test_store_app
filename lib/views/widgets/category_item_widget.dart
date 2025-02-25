import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/views/controllers/providers/category_item_provider.dart';

class CategoryItemWidget extends ConsumerWidget {
  const CategoryItemWidget({super.key});

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
