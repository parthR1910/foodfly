import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';

class PersonalDetail extends StatelessWidget {
  const PersonalDetail({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Personal Details'),),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment:
          CrossAxisAlignment.start,children: [
          ListTile(
            leading: const Icon(Icons.home),
            title: Text('Address : ', style: TextStyle(fontSize: 15.sp, color: Colors.grey)),
            subtitle: Text(userModel.address, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
          ),
          ListTile(
            leading: const Icon(Icons.date_range),
            title: Text('DOB : ', style: TextStyle(fontSize: 15.sp, color: Colors.grey)),
            subtitle: Text('', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: Text('Phone Number : ', style: TextStyle(fontSize: 15.sp, color: Colors.grey)),
            subtitle: Text(userModel.phoneNumber, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
          ),
          ListTile(
            leading: const Icon(Icons.pin_drop),
            title: Text('Pin Code : ', style: TextStyle(fontSize: 15.sp, color: Colors.grey)),
            subtitle: Text(userModel.pincode, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: Text('Assign Address : ', style: TextStyle(fontSize: 15.sp, color: Colors.grey)),
            subtitle: Text('', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
          ),


        ]),
      ),
    );
  }
}
