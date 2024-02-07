import 'package:flutter/services.dart';
import 'package:food_fly/framework/controller/authentication/address_controller.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/widgets/common_loading.dart';
import '../../../../utils/form_validator.dart';
import '../../../../utils/theme/app_colors.dart';
import '../../../../utils/theme/app_text_style.dart';
import '../../../../utils/theme/theme.dart';
import '../../../../utils/widgets/common_form_field.dart';

class AddressForm extends ConsumerStatefulWidget {
  const AddressForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddressFormState();
  }
}

class _AddressFormState extends ConsumerState<AddressForm> {
  @override
  Widget build(BuildContext context) {
    final appString = ref.watch(appStringController);
    final addressWatch = ref.watch(addressController);
    return CommonLoading(
      show: addressWatch.loading,
      child: Form(
        key: addressWatch.addressKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appString.keyPhoneNo,
              style: AppTextStyle.w4.copyWith(
                color: AppColors.kBlack,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 6.h),
            CommonFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: addressWatch.phoneController,
              hintText: appString.keyTypeYourPhoneNumber,
              validator: phoneValidator,

              onSaved: (value) {},
            ),
            SizedBox(height: 16.h),
            Text(
              appString.keyAddress,
              style: AppTextStyle.w4.copyWith(
                color: AppColors.kBlack,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 6.h),
            CommonFormField(
              controller: addressWatch.addressController,
              hintText: appString.keyTypeYourAddress,
              validator: addressValidator,
              suffixIcon: IconButton(
                  onPressed: () {
                    // fetchLocation();
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
              appString.keyPostalCode,
              style: AppTextStyle.w4.copyWith(
                color: AppColors.kBlack,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 6.h),
            CommonFormField(
              controller: addressWatch.postalCodeController,
              hintText: appString.keyTypeYourPostalCode,
              onSaved: (value) {},
            ),
            SizedBox(height: 16.h),
            Text(
              appString.keyCity,
              style: AppTextStyle.w4.copyWith(
                color: AppColors.kBlack,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 6.h),
            CommonFormField(
              controller: addressWatch.cityController,
              hintText: appString.keySelectYourCity,
              onSaved: (value) {},
            ),
            SizedBox(height: 24.h)
          ],
        ),
      ),
    );
  }
}
