import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:food_fly_delivery_partner/common/config/router/app_routes.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/order_model.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/date_time_formater.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/shimmer_widget.dart';

class OrderShimmerCard extends StatelessWidget {
  const OrderShimmerCard({super.key,});


  @override
  Widget build(BuildContext context) {

    return Card(
        elevation: 0,
        color: Colors.white,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         ShimmerWidget(height: 18.h, width: 80.h,),

                         ShimmerWidget(height: 18.h, width: 120.w,),
                      ],
                    ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           ShimmerWidget(height: 16.h, width: 200.w,),
                          SizedBox(
                            height: 5.h,
                          ),
                           ShimmerWidget(height: 16.h, width: 160.w,),
                          SizedBox(
                            height: 5.h,
                          ),
                           ShimmerWidget(height: 16.h, width: 140.w,),

                        ],
                      ),
                    ),
                    ShimmerWidget(height: 40.h, width: 40.w)
                  ],
                ),
                Divider(
                  height: 20.h,
                  color: Colors.grey.shade300,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerWidget(height: 20.h, width: 50.h,),

                    ShimmerWidget(height: 20.h, width: 70.w,),
                  ],
                ),
              ],
            )));
  }
}
