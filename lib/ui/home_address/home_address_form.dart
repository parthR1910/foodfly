import '../../framework/controller/home_address/home_address_controller.dart';
import '../utils/form_validator.dart';
import '../utils/theme/app_colors.dart';
import '../utils/theme/app_text_style.dart';
import '../utils/theme/theme.dart';
import '../utils/widgets/common_form_field.dart';

class HomeAddressForm extends ConsumerWidget {
  const HomeAddressForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressWatch = ref.watch(homeAddressController);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Text(
          "Address",
          style: AppTextStyle.w4.copyWith(
            color: AppColors.kBlack,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 6.h),
        CommonFormField(
          controller: addressWatch.addressController,
          hintText: "Your Address",
          validator: addressValidator,
          suffixIcon: IconButton(
              onPressed: () {
                addressWatch.getCurrentLocation();
              },
              icon: const Icon(
                Icons.location_on_rounded,
                color: AppColors.kPrimary,
              )),
          onSaved: (value) {},
        ),
        SizedBox(height: 16.h),
        Text(
          "Postal Code",
          style: AppTextStyle.w4.copyWith(
            color: AppColors.kBlack,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 6.h),
        CommonFormField(
          controller: addressWatch.postalCodeController,
          hintText:"your postal code",
          onSaved: (value) {},
        ),
        SizedBox(height: 16.h),
        Text(
          "City",
          style: AppTextStyle.w4.copyWith(
            color: AppColors.kBlack,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 6.h),
        CommonFormField(
          controller: addressWatch.cityController,
          hintText:"City",
          onSaved: (value) {},
        ),
        SizedBox(height: 16.h),
        Text(
          "State",
          style: AppTextStyle.w4.copyWith(
            color: AppColors.kBlack,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 6.h),
        CommonFormField(
          controller: addressWatch.stateController,
          hintText:"State",
          onSaved: (value) {},
        ),
        SizedBox(height: 24.h)
      ],
    );
  }
}
