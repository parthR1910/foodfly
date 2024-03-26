import 'package:flutter/services.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/helper/validator.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/common_form_field.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/common_loading.dart';
import 'package:food_fly_delivery_partner/features/auth/authentication/address_controller.dart';

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
    final addressWatch = ref.watch(addressController);
    return CommonLoading(
      show: addressWatch.loading,
      child: Form(
        key: addressWatch.addressKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone Number',
              style: TextStyle(
                color: Colors.black,
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
              hintText: 'Enter Your Phone Number',
              validator: phoneValidator,
              onSaved: (value) {},
            ),
            SizedBox(height: 16.h),
            Text(
              'Address',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 6.h),
            CommonFormField(
              controller: addressWatch.addressController,
              hintText: 'Enter Your Address',
              validator: addressValidator,
              suffixIcon: IconButton(
                  onPressed: () {
                    // fetchLocation();
                    addressWatch.getCurrentLocation();
                  },
                  icon:  Icon(
                    Icons.location_on_rounded,
                    color: context.primaryColor,
                  )),
              onSaved: (value) {},
            ),
            SizedBox(height: 16.h),
            Text(
              'Postal Code',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 6.h),
            CommonFormField(
              controller: addressWatch.postalCodeController,
              hintText: 'Enter Your Postal Code',
              onSaved: (value) {},
            ),
            SizedBox(height: 16.h),
            Text(
              'City',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 6.h),
            CommonFormField(
              controller: addressWatch.cityController,
              hintText: 'Enter Your City',
              onSaved: (value) {},
            ),
            SizedBox(height: 24.h)
          ],
        ),
      ),
    );
  }
}
