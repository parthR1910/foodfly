import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/common_loading.dart';
import 'package:food_fly_delivery_partner/features/auth/authentication/address_controller.dart';

import 'helper/address_view.dart';

class Address extends ConsumerWidget {
  const Address({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonLoading(
      show: ref.watch(addressController).loading,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: _appBar(ref, context),
          body:  const AddressView(),
        ),
      ),
    );
  }

  AppBar _appBar(WidgetRef ref, BuildContext context) => AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.adaptive.arrow_back),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address',
                style: TextStyle(color: Colors.black, fontSize: 22.sp)),
            Text('Make Sure its valid Address',
                style: TextStyle(color: Colors.grey, fontSize: 14.sp))
          ],
        ),
      );
}
