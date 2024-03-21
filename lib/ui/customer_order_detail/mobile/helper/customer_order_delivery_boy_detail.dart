import 'package:food_fly/framework/model/user/user_model.dart';
import 'package:food_fly/framework/service/fire_store_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/app_string.dart';
import '../../../utils/theme/app_text_style.dart';
import '../../../utils/theme/theme.dart';

class CustomerOrderDeliveryBoyDetail extends ConsumerWidget {
  final String deliveryBoyId;
  const CustomerOrderDeliveryBoyDetail({super.key,required this.deliveryBoyId});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final appStringWatch = ref.watch(appStringController);

    return StreamBuilder<UserModel>(
      stream: FireStoreService.fireStoreService.getDeliveryBoyDataFireStore(deliveryBoyId: deliveryBoyId),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }else if(snapshot.hasData){
          final deliveryBoyData = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Delivery boy", style: AppTextStyle.w4.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.kBlack
              ),),
              SizedBox(height: 8.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(appStringWatch.keyName,style: AppTextStyle.w4.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.kGrey
                  ),),
                  Text(deliveryBoyData.name??"",style: AppTextStyle.w4.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.kBlack
                  ),)
                ],
              ),
              SizedBox(height: 6.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(appStringWatch.keyPhoneNo,style: AppTextStyle.w4.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.kGrey
                  ),),
                  Text(deliveryBoyData.phone!.substring(3)??"",style: AppTextStyle.w4.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.kBlack
                  ),)
                ],
              ),
              SizedBox(height: 6.h,),
              Text(appStringWatch.keyAddress,style: AppTextStyle.w4.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.kGrey
              ),),
              SizedBox(height: 15.h,),
              Text(deliveryBoyData.address??"",style: AppTextStyle.w4.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.kBlack
              ),),
              SizedBox(height: 10.h,),
              Text("Contact With delivery boys:",style: AppTextStyle.w4.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.kPrimary
              )),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.kLightGreen,
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r))
                        ),
                        onPressed: (){
                          Future.delayed(const Duration(milliseconds: 700),()async{
                            await launchUrl(Uri(
                                scheme: 'tel',
                                path: deliveryBoyData.phone
                            ));
                          });
                        }, icon: const Icon(Icons.call,color: AppColors.kWhite,), label: Text("Call Here",style: AppTextStyle.w4.copyWith(
                        color: AppColors.kWhite
                    ))),
                  ),
                ],
              )
            ],
          );
        }else{
          return const Center(child: Text("No data found"),);
        }

    },);
  }
}
