
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/order_model.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/date_time_formater.dart';

import 'customer_order_product.dart';

class CustomerOrderDetail extends StatelessWidget {
  const CustomerOrderDetail({super.key, required this.orderModel});
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order Details',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w700),),
         SizedBox(height: 15.h,),
         ListTile(
           onTap: (){
             // Clipboard.setData(ClipboardData(text: orderModel.userAddress));
             Fluttertoast.showToast(
                 msg: 'Copy to clip board',
                 backgroundColor: context.colorScheme.onBackground,
                 textColor: context.colorScheme.background);
           },
           tileColor: context.primaryColor.withOpacity(.1),
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r),side: BorderSide(color: Colors.grey.shade200)),
          leading: const Icon(Icons.location_on),
          title: Text(

            // orderModel.userAddress,
            'orderModel.userAddress',
            style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),),
           trailing: const Icon(Icons.copy_rounded),
        ),
            SizedBox(height: 20.h),
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(15.r),
        //       border: Border.all(color: Colors.grey.shade200)),
        //   child: Column(children: [
        //     customRow(context, 'Order Date', orderModel.orderDateTime.format('dd-MMM-yyyy')),
        //     SizedBox(height: 10.h),
        //     customRow(context, 'Order Id', '#${orderModel.orderId}'),
        //     SizedBox(height: 10.h),
        //     customRow(context, 'Order Source', orderModel.orderSource),
        //     SizedBox(height: 10.h),
        //     customRow(context, 'Order Status', orderModel.orderStatus),
        //     SizedBox(height: 10.h),
        //    if(orderModel.cancelOrder.isNotEmpty && orderModel.cancelOrder != ' ')
        //    ...[ customRow(context, 'Cancel Order Date', orderModel.cancelOrder),
        //     SizedBox(height: 10.h),],
        //     if(orderModel.cancelReason!='false')
        //   ...[  customRow(context, 'Cancel Reasons', orderModel.cancelReason),
        //     SizedBox(height: 10.h),]
        //   ]),
        // )
      ],
    );
  }
}
