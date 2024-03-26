import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/order_detail_model.dart';
import 'package:food_fly_delivery_partner/common/model/order_model.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';

class CustomerOrderProduct extends StatelessWidget {
  const CustomerOrderProduct({super.key, required this.orderDetailModel});
  final OrderDetailModel orderDetailModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        Container(
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                    blurRadius: 4, spreadRadius: 1, color: Colors.grey.shade300)
              ]),
          child: ListTile(
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            leading: CachedNetworkImage(
              imageUrl: orderDetailModel.foodDataModel.image ?? '',
              height: 70.h,
              width: 70.w,
              errorWidget: (context, url, error) => const Center(
                child: Icon(Icons.error),
              ),
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(color: Colors.black),
              ),
            ),
            title: Text(
              'Product Id - #${orderDetailModel.foodDataModel.foodId?.substring(1, 5)}',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderDetailModel.foodDataModel.name ?? '',
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: context.primaryColor),
                ),
                Text(
                  '₹ ${orderDetailModel.foodDataModel.price}',
                  style:
                      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Tax - ${orderDetailModel.foodDataModel.tax}',
                  style:
                      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

Widget customRow(BuildContext context, String title, String data) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (title != 'Order Date')
        Divider(
          color: Colors.grey.shade200,
        ),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: TextStyle(fontSize: 15.sp, color: Colors.grey),
        ),
        SizedBox(width: 10.h),
        Expanded(
          child: Text(
            data,
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
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
      ]),
    ],
  );
}
