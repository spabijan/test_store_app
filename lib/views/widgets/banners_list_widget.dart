import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store_app/views/controllers/providers/banner_provider.dart';
import 'package:test_store_app/services/manage_http_response.dart';

class BannerListWidget extends ConsumerStatefulWidget {
  const BannerListWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends ConsumerState<BannerListWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bannersProvider.notifier).loadBanner();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
        bannersProvider,
        (previous, next) => next.whenOrNull(error: (error, stackTrace) {
              var errorMessage =
                  error is HttpError ? error.message : error.toString();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(errorMessage)));
            }));

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
                itemBuilder: (context, index) => Image.network(
                      data.value[index].image,
                      fit: BoxFit.cover,
                    ));
          },
          error: (error) {
            var e = error.error;
            var errorMessage = e is HttpError ? e.message : error.toString();
            return Center(child: Text('Error $errorMessage'));
          },
          loading: (loading) {
            return const CircularProgressIndicator.adaptive();
          },
        ),
      ),
    );
  }
}
