import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_fly/framework/controller/home_address/home_address_controller.dart';
import 'package:food_fly/ui/home_address/home_address_form.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:food_fly/ui/utils/widgets/common_button.dart';
import 'package:food_fly/ui/utils/widgets/common_loading.dart';
import '../utils/theme/app_colors.dart';
import '../utils/theme/app_text_style.dart';

class HomeAddress extends ConsumerStatefulWidget {
  const HomeAddress({super.key});

  @override
  ConsumerState<HomeAddress> createState() => _HomeAddressState();
}

class _HomeAddressState extends ConsumerState<HomeAddress> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeAddressController).addAddressToField();
    });
  }
  @override
  Widget build(BuildContext context) {
    final addressWatch = ref.watch(homeAddressController);
    return CommonLoading(
      show: addressWatch.loading,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text("Home Address",
              style: AppTextStyle.w5
                  .copyWith(color: AppColors.kBlack, fontSize: 22.sp)),
        ),
        body: Padding(
          padding:  EdgeInsets.only(left: 16.w,right: 16.w,top: 40.h),
          child:  SingleChildScrollView(
            child: Form(
              key: addressWatch.addressKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 const HomeAddressForm(),
                  SizedBox(height: 30.h,),
                  CommonButton(
                      padding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 50.w),
                      child: Text(
                        "Change Address",
                        style: AppTextStyle.w5.copyWith(fontSize: 14.sp),
                      ),
                      onTap: ()async{
                       await addressWatch.changeAddress();
                       Fluttertoast.showToast(
                           msg: "Successfully Changed address",
                           toastLength: Toast.LENGTH_SHORT,
                           gravity: ToastGravity.CENTER,
                           timeInSecForIosWeb: 1,
                           backgroundColor: Colors.red,
                           textColor: Colors.white,
                           fontSize: 16.0
                       );
                       if(context.mounted){
                       Navigator.pop(context);}
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
