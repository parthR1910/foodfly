import 'package:flutter/scheduler.dart';
import 'package:food_fly/framework/controller/profile/edit_profile_controller/edit_profile_controller.dart';
import 'package:food_fly/ui/edit_profile/helper/edit_profile_form.dart';
import 'package:food_fly/ui/edit_profile/helper/edit_profile_img.dart';
import 'package:food_fly/ui/utils/extension/widget_extension.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import '../utils/theme/app_colors.dart';
import '../utils/theme/theme.dart';
import '../utils/widgets/common_button.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController shopController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(editProfileController).addDataToTextField();
    });
  }
  @override
  Widget build(BuildContext context) {
    final editProfileWatch = ref.watch(editProfileController);
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: PopScope(
        canPop: true,
        onPopInvoked: (v){
          Future.delayed(const Duration(milliseconds: 500),(){
            editProfileWatch.clearData();
          });
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Edit Profile",style: AppTextStyle.w5.copyWith(fontSize: 25.sp,color: AppColors.kPrimary),),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 80.h,),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: EditProfileImg(),
                  ),
                  SizedBox(height: 30.h,),
                  const EditProfileForm().paddingHorizontal(16.w),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonButton(
                    onTap: editProfileWatch.isUpdate? () {

                    }:null,
                    padding:  EdgeInsets.symmetric(vertical: 12.h,horizontal: size.width *0.3.w),
                    backgroundColor: editProfileWatch.isUpdate?AppColors.kPrimary:AppColors.kGrey,
                    child: Text(
                     "Submit",
                      style: AppTextStyle.w5.copyWith(fontSize: 14.sp),
                    ),
                  ).paddingHorizontal(16.w)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }}