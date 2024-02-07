import 'package:food_fly/framework/controller/food_controller/food_controlller.dart';
import 'package:lottie/lottie.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';


class DeleteFoodBottomSheet extends ConsumerStatefulWidget{
  final String id;
  const DeleteFoodBottomSheet( {super.key,required this.id});

  @override
  ConsumerState<DeleteFoodBottomSheet> createState() => _SettingDeleteAcBottomSheetState();
}

class _SettingDeleteAcBottomSheetState extends ConsumerState<DeleteFoodBottomSheet> with SingleTickerProviderStateMixin {

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
    final newsWatch = ref.watch(foodController);

    return Container(
      height: 320.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Are you sure you want to delete this product?",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),),
          Expanded(
            child: Align(
              alignment: Alignment.center,
                child: Lottie.asset(
                  controller: deleteController,
                  "assets/lottie/delete_product.json",
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
                  onPressed: (){
                    newsWatch.deleteFood(id: widget.id, context: context);
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
