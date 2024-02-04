import 'package:food_fly/ui/utils/theme/theme.dart';
import 'address_form.dart';
import 'continue_button.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24.w, 74.h, 24.w, 0.h),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AddressForm(),
          ContinueButton(),
        ],
      ),
    );
  }
}
