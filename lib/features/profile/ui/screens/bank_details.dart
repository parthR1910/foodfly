import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';

class BankDetails extends StatelessWidget {
  const BankDetails({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox();
    // return Scaffold(
    //   appBar: AppBar(title: const Text('Bank Details'),),
    //
    //   body: SingleChildScrollView(
    //     child: Column(crossAxisAlignment:
    //       CrossAxisAlignment.start,children: [
    //       ListTile(
    //         leading: const Icon(Icons.account_balance),
    //         title: Text('Bank Name : ', style: TextStyle(fontSize: 15.sp, color: Colors.grey)),
    //         subtitle: Text(userModel.bankName??'-', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
    //       ),
    //       ListTile(
    //         leading: const Icon(Icons.account_circle),
    //         title: Text('Account Number : ', style: TextStyle(fontSize: 15.sp, color: Colors.grey)),
    //         subtitle: Text(userModel.accountNumber??'-', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
    //       ),
    //       ListTile(
    //         leading: const Icon(Icons.code),
    //         title: Text('IFSC Code : ', style: TextStyle(fontSize: 15.sp, color: Colors.grey)),
    //         subtitle: Text(userModel.ifscCode??'-', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
    //       ),
    //     ]),
    //   ),
    // );
  }
}
