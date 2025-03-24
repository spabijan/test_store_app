import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/screens/category_screen/components/product_list_grid_widget.dart';
import 'package:test_store_app/screens/category_screen/models/product_view_model.dart';
import 'package:test_store_app/screens/category_screen/providers/search_product_provider.dart';
import 'package:test_store_app/screens/category_screen/screens/product_detail_screen.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _query = '';

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () =>
                      setState(() => _query = _searchController.text.trim()),
                  icon: const Icon(Icons.search)),
              labelText: 'Search products...'),
        )),
        body: _query.isEmpty
            ? const SizedBox.shrink()
            : Column(
                children: [
                  const SizedBox(height: 16),
                  Consumer(builder: (context, ref, child) {
                    final searchResult =
                        ref.watch(searchProductProvider(query: _query));
                    return searchResult.map(
                        data: (data) {
                          return data.value.isEmpty
                              ? const Center(child: Text('No product found'))
                              : Expanded(
                                  child: ProductListGrid(
                                      productList: data.value,
                                      onProductClicked: _gotoProductDetails));
                        },
                        error: (error) => Center(
                                child: Column(
                              children: [
                                const Text(
                                    'Error while executing search request'),
                                Text(error.toString())
                              ],
                            )),
                        loading: (loading) => const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ));
                  }),
                ],
              ));
  }

  void _gotoProductDetails(ProductViewModel product) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductDetailScreen(viewModel: product),
    ));
  }
}
