import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/framework/service/fire_store_service.dart';
import 'package:food_fly/ui/user_profile/mobile/user_profile.dart';
import 'package:food_fly/ui/utils/common_device_config.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:page_transition/page_transition.dart';
import 'helper/home_view.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {

  // @override
  // void initState() {
  //   super.initState();
  //   final user = BoxService.boxService.userModelBox.get(userModelDetailKey);
  //   print(user!.email);
  // }

  @override
  Widget build(BuildContext context, ) {
    mobileDeviceConfig(context);
    final appString = ref.watch(appStringController);
    return Scaffold(
      appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(appString.keyFoodFly,
                  style: AppTextStyle.w5.copyWith(
                    fontSize: 22.sp,
                  )),
              Text(
                appString.keyLetsGetSomeFoods,
                style: AppTextStyle.w3
                    .copyWith(fontSize: 14.sp, color: AppColors.kGrey),
              )
            ],
          ),
          actions: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, PageTransition(child: const UserProfile(), type: PageTransitionType.bottomToTop));
              },
              child: Container(
                height: 50.h,
                width: 50.w,
                margin: EdgeInsets.only(right: 10.w),
                decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(8.r)),
                child: const Icon(Icons.person),
              ),
            ),
          ]),
      body: StreamBuilder<List<FoodDataModel>>(
        stream: FireStoreService.fireStoreService.getFoodDataFireStore(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else if(snapshot.hasData){
            final foodDataList = snapshot.data!;
            // for(var i in foodDataList){
            //   print(i.name);
            // }
            return  HomeView(foodList: foodDataList,);
          }
         else{ return const Center(child: Text("No data is inserted"),);}
        }
      ),
    );
  }
}
