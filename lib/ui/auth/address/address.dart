import 'package:responsive_builder/responsive_builder.dart';

import '../../utils/theme/theme.dart';
import 'mobile/address_mobile.dart';

class Address extends StatelessWidget {
  const Address({super.key});

  @override
  Widget build(BuildContext context) => ScreenTypeLayout.builder(
        mobile: (BuildContext context) => const AddressMobile(),
      );
}
