import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/order_detail_model.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';

import 'customer_order_product.dart';

class CustomerOrderDetail extends StatelessWidget {
  const CustomerOrderDetail({super.key, required this.orderDetailModel});
  final OrderDetailModel orderDetailModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Details',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 15.h,
        ),
        ListTile(
          onTap: () {
            Clipboard.setData(
                ClipboardData(text: orderDetailModel.userModel.address ?? ''));
            Fluttertoast.showToast(
                msg: 'Copy to clip board',
                backgroundColor: context.colorScheme.onBackground,
                textColor: context.colorScheme.background);
          },
          tileColor: context.primaryColor.withOpacity(.1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
              side: BorderSide(color: Colors.grey.shade200)),
          leading: const Icon(Icons.location_on),
          title: Text(
            orderDetailModel.userModel.address ?? '',
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(Icons.copy_rounded),
        ),
        SizedBox(height: 20.h),
        Container(
          // padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(15.r),
              // border: Border.all(color: Colors.grey.shade200)
              ),
          child: Column(children: [
            customRow(
                context, 'Order Date', orderDetailModel.orderModel.orderDate),
            // SizedBox(height: 10.h),
            customRow(context, 'Order Id',
                orderDetailModel.orderModel.id.substring(0, 5)),
            // SizedBox(height: 10.h),

            // SizedBox(height: 10.h),
            customRow(
                context,
                'Order Status',
                orderDetailModel.orderModel.isDelivered
                    ? 'Delivered'
                    : 'Pending'),
            // SizedBox(height: 10.h),

            customRow(context, 'Payment Type',
                orderDetailModel.orderModel.paidOrNot ? 'Online' : 'COD'),

            // SizedBox(height: 10.h),
            customRow(context, 'Customer Name',
                orderDetailModel.userModel.name ?? ''),
            customRow(
              context,
              'Payment Amount',
              '₹ ${orderDetailModel.foodDataModel.price ?? 0 - (orderDetailModel.foodDataModel.offPrice ?? 0)} ',
            ),

            // if(orderModel.cancelOrder.isNotEmpty && orderModel.cancelOrder != ' ')
            // ...[ customRow(context, 'Cancel Order Date', orderModel.cancelOrder),
            //   SizedBox(height: 10.h),],
            //   if(orderModel.cancelReason!='false')
            // ...[  customRow(context, 'Cancel Reasons', orderModel.cancelReason),
            //   SizedBox(height: 10.h),]
          ]),
        )
      ],
    );
  }
}
