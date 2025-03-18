import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_store_app/model/services/manage_http_response.dart';
import 'package:test_store_app/screens/account_details/providers/delete_order_provider.dart';
import 'package:test_store_app/screens/account_details/providers/get_orders_provider.dart';
import 'package:test_store_app/screens/account_details/providers/order_count_provider.dart';
import 'package:test_store_app/screens/account_details/providers/order_list_item_provider.dart';
import 'package:test_store_app/screens/account_details/widgets/order_list_tile_widget.dart';
import 'package:test_store_app/screens/cart_screen/widgets/cart_info_icon.dart';
import 'package:test_store_app/screens/category_screen/models/order_view_model.dart';
import 'package:test_store_app/screens/navigation/provider/navigation_providers.dart';
import 'package:test_store_app/screens/navigation/route_names.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(deleteOrderProvider, (previous, next) {
      next.whenOrNull(error: (error, stackTrace) {
        if (error is HttpError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.message)));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        }
      });
    });

    final orders = ref.watch(ordersProvider);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
            child: Consumer(
              builder: (_, WidgetRef ref, __) {
                final ordersCount = ref.watch(orderCountProvider);
                return AppBarWidget(itemCount: ordersCount, text: 'Orders');
              },
            )),
        body: orders.map(data: (data) {
          return data.value.isEmpty
              ? const Center(child: Text('No order found'))
              : ListView.builder(
                  itemCount: data.value.length,
                  itemBuilder: (context, index) {
                    final orderVM = data.value[index];
                    return ProviderScope(
                        overrides: [
                          orderListItemProvider.overrideWithValue(orderVM)
                        ],
                        child: InkWell(
                            onTap: () {
                              ref
                                  .read(selectedOrderDetailsProvider.notifier)
                                  .state = orderVM;
                              GoRouter.of(context)
                                  .goNamed(RouteNames.accountOrdersDetails);
                            },
                            child: const OrderListTileWidget()));
                  },
                );
        }, error: (error) {
          return const Center(
            child: Text('Error while fetching order list.'),
          );
        }, loading: (loading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }));
  }
}
