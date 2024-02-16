import 'package:flutter/services.dart';

import '../../../framework/controller/profile/edit_profile_controller/edit_profile_controller.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/theme.dart';
import '../../utils/widgets/common_form_field.dart';

class EditProfileForm extends ConsumerWidget {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editProfileWatch = ref.watch(editProfileController);
    return   Column(
      children: [
        CommonFormField(
          controller: editProfileWatch.nameController,
          onChanged: (v){
            editProfileWatch.checkIsUpdateOrNot();
          },
          hintText: "Name ",prefixIcon: const Icon(Icons.person,color: AppColors.kPrimary,),),
        SizedBox(height: 20.h,),
        // CommonFormField(
        //     controller: editProfileWatch.emailController,
        //     onChanged: (v){
        //       editProfileWatch.checkIsUpdateOrNot();
        //     },
        //     hintText: "email",prefixIcon: const Icon(Icons.email,color: AppColors.kPrimary,)),
        // SizedBox(height: 20.h,),
        // CommonFormField(
        //     controller: editProfileWatch.addressController,
        //     onChanged: (v){
        //       editProfileWatch.checkIsUpdateOrNot();
        //     },
        //     hintText: "address",prefixIcon: const Icon(Icons.home,color: AppColors.kPrimary,)),
        // SizedBox(height: 20.h,),
        CommonFormField(
            controller: editProfileWatch.phoneController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (v){
              editProfileWatch.checkIsUpdateOrNot();
            },
            hintText: "phone",prefixIcon: const Icon(Icons.phone,color: AppColors.kPrimary,)),
      ],
    );
  }
}
