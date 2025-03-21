import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/screens/components/banner/provider/banner_provider.dart';
import 'package:test_store_app/model/services/manage_http_response.dart';

class BannerListWidget extends ConsumerWidget {
  const BannerListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(bannersProvider, (previous, next) {
      next.whenOrNull(error: (error, stackTrace) {
        var errorMessage =
            error is HttpError ? error.message : error.toString();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));
      });
    });

    final banners = ref.watch(bannersProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 170,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xfff7f7f7)),
        child: banners.map(
          data: (data) {
            return PageView.builder(
                itemCount: data.value.length,
                itemBuilder: (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        data.value[index].image,
                        fit: BoxFit.cover,
                      ),
                    ));
          },
          error: (error) {
            var e = error.error;
            var errorMessage = e is HttpError ? e.message : error.toString();
            return Center(child: Text('Error $errorMessage'));
          },
          loading: (loading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          },
        ),
      ),
    );
  }
}
