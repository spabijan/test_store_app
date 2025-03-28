import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/screens/category_screen/providers/product_item_provider.dart';

class ManagedListGrid<T> extends StatelessWidget {
  const ManagedListGrid(
      {required this.gridElements,
      required this.onTileClicked,
      required this.child,
      super.key});

  final List<T> gridElements;
  final Function(T model) onTileClicked;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth < 600 ? 2 : 4;
    final aspectRatio = screenWidth < 600 ? 3 / 4 : 4 / 5;

    return GridView.builder(
      itemCount: gridElements.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: aspectRatio,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => onTileClicked(gridElements[index]),
          child: ProviderScope(overrides: [
            productItemProvider.overrideWithValue(gridElements[index])
          ], child: child),
        );
      },
    );
  }
}
