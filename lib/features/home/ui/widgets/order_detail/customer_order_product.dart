import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/order_model.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';

class CustomerOrderProduct extends StatelessWidget {
  const CustomerOrderProduct({super.key, required this.orderModel});
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Text(
          'Payment Details',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 15.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: Colors.grey.shade200)),
          child: Column(children: [
            // customRow(context, 'Payment Id', orderModel.paymentId),
            SizedBox(height: 10.h),
            // customRow(context, 'Payment Type', orderModel.paymentType),
            SizedBox(height: 10.h),
            Divider(
              color: Colors.grey.shade200,
            ),
            Row(children: [
              Text(
                'Payment Amount',
                style: TextStyle(fontSize: 13.sp, color: Colors.grey),
              ),
              const Spacer(),
              Text(
                // '₹${orderModel.paymentAmount}',
                '₹ 500 ',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ])
          ]),
        ),
        SizedBox(
          height: 30.h,
        ),
        Text(
          'Order Products',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 15.h,
        ),
        // ...orderModel.items.map((e) => Container(
        //       margin: EdgeInsets.only(bottom: 10.h),
        //       decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.circular(15.r),
        //           boxShadow: [
        //             BoxShadow(
        //                 blurRadius: 4,
        //                 spreadRadius: 1,
        //                 color: Colors.grey.shade300)
        //           ]),
        //       child: ListTile(
        //         tileColor: Colors.white,
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(10.r),
        //             ),
        //         leading: CachedNetworkImage(
        //           imageUrl: e.productThumbImages,
        //           height: 70.h,
        //           width: 70.w,
        //            errorWidget: (context, url, error) => const Center(child: Icon(Icons.error),),
        //           placeholder: (context, url) => const Center(
        //             child: CircularProgressIndicator(
        //               color: Colors.black
        //             ),
        //           ),
        //         ),
        //         title: Text(
        //           'Product Id - ${e.productId}',
        //           style:
        //               TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800),
        //         ),
        //         subtitle: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               '₹ ${e.productAmount}',
        //               style: TextStyle(
        //                   fontSize: 13.sp, fontWeight: FontWeight.w600),
        //             ),
        //             Text(
        //               'Store Location - ${e.storeLocation}',
        //               style: TextStyle(
        //                   fontSize: 13.sp, fontWeight: FontWeight.w600),
        //             ),
        //           ],
        //         ),
        //       ),
        //     )),
      ],
    );
  }

}
  Widget customRow(BuildContext context, String title, String data) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: TextStyle(fontSize: 13.sp, color: Colors.grey),
      ),
      SizedBox(width: 10.h),
      Expanded(
        child: Text(
          data,
          textAlign: TextAlign.end,
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
        ),
      ),
      SizedBox(
        width: 10.w,
      ),
      if (title == 'Payment Id')
        GestureDetector(
          onTap: () {
            Clipboard.setData(const ClipboardData(text: 'data'));
            Fluttertoast.showToast(
                msg: 'Copy to clip board',
                backgroundColor: context.colorScheme.onBackground,
                textColor: context.colorScheme.background);
          },
          child: const Icon(Icons.copy_rounded),
        ),
    ]);
  }
