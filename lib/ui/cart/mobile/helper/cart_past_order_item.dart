import 'package:food_fly/ui/utils/theme/theme.dart';

import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/app_text_style.dart';

class CartPastOrderItem extends StatelessWidget {
  const CartPastOrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    List item =[
      ["Kari Sleman","1 item • IDR 289.000","Jun 12, 14:00",""],
      ["Avosalado","1 item • IDR 6.000.000","Mei 2, 09:00","Cancelled"],
    ];
    return ListView.builder(
      itemCount: item.length,
      itemBuilder: (context, index) {
        final data = item[index];
        return Padding(
          padding:  EdgeInsets.only(top: 10.h),
          child: ListTile(
            leading: const FlutterLogo(size: 30,),
            title: Text(data[0], style: AppTextStyle.w4.copyWith(fontSize: 16.sp,color: AppColors.kBlack),),
            subtitle: Text(data[1],style: AppTextStyle.w4.copyWith(fontSize: 13.sp,color: AppColors.kGrey)),
            trailing: Column(
              children: [
                Text(data[2],style: AppTextStyle.w4.copyWith(fontSize: 13.sp,color: AppColors.kGrey)),
                Text(data[3],style: AppTextStyle.w4.copyWith(fontSize: 13.sp,color: AppColors.kLighRed))
              ],
            ),
          ),
        );
      },);
  }
}
