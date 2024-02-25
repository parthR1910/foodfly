import 'package:flutter/material.dart';
import 'package:food_fly_delivery_partner/features/home/ui/widgets/pending_orders/pending_orders_view.dart';

import 'delivered_orders/delivered_orders_view.dart';

class TabBarViewWidget extends StatelessWidget {
  const TabBarViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBarView(children: [
      PendingOrderView(),
      DeliveredOrdersView(),
    ]);
  }
}
