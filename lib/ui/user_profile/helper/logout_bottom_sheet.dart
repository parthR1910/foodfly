import 'package:lottie/lottie.dart';
import '../../../framework/controller/authentication/login_controller.dart';
import '../../utils/common_device_config.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/theme.dart';


class LogoutBottomSheet extends ConsumerStatefulWidget{
  const LogoutBottomSheet( {super.key});

  @override
  ConsumerState<LogoutBottomSheet> createState() => _LogoutBottomSheet();
}

class _LogoutBottomSheet extends ConsumerState<LogoutBottomSheet> with SingleTickerProviderStateMixin {

  late AnimationController deleteController;

  @override
  void initState() {
    super.initState();
    deleteController = AnimationController(vsync: this,duration: const Duration(seconds: 2));
  }
  @override
  void deactivate() {
    super.deactivate();
    deleteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginWatch = ref.watch(loginController);
    mobileDeviceConfig(context);
    return Container(
      height: 320.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Are you sure you want to logout?",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w600),),
          Expanded(
            child: Align(
                alignment: Alignment.center,
                child: Lottie.asset(
                  controller: deleteController,
                  "assets/lottie/logout.json",
                  onLoaded: (_){
                    deleteController.repeat();
                  },
                  fit: BoxFit.fill,)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    backgroundColor: AppColors.kPrimary,
                  ), child: const Text("Cancel",style: TextStyle(color: Colors.white),),
                ),
              ),
              SizedBox(width: 8.w,),
              Expanded(
                child: ElevatedButton(
                  onPressed: ()async{
                    loginWatch.signOut(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    backgroundColor: AppColors.kPrimary,
                  ), child: const Text("Yes Im sure",style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
