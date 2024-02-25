import '../../../../common/config/theme/theme_export.dart';

class NotificationListScreen extends StatelessWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(),
      body:           Center(child: Text('No Record Found',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w600),),)

    );
  }
}
