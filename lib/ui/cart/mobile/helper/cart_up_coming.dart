import 'package:food_fly/ui/cart/mobile/helper/cart_tile.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

class CartUpComing extends StatelessWidget {
  const CartUpComing({super.key});

  @override
  Widget build(BuildContext context) {
    List item =[
      ["Avosalado","3 items • IDR 18.000.000"],
      ["Kopi Kudda","10 items • IDR 450.000"],
      ["Es Tong-Tong","2 items • IDR 900.500"],
      ["Bwang Puttie","10 items • IDR 450.000"],
    ];
    return ListView.builder(
      itemCount: item.length,
      itemBuilder: (context, index) {
        final data = item[index];
        return CartTile();
      // return Padding(
      //   padding:  EdgeInsets.only(top: 10.h),
      //   child: ListTile(
      //     leading: const FlutterLogo(size: 30,),
      //     title: Text(data[0], style: AppTextStyle.w4.copyWith(fontSize: 16.sp,color: AppColors.kBlack),),
      //     subtitle: Text(data[1],style: AppTextStyle.w4.copyWith(fontSize: 13.sp,color: AppColors.kGrey)),
      //   ),
      // );
    },);

  }
}
