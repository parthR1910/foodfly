import 'package:food_fly/framework/model/notification_model.dart';
import 'package:food_fly/framework/service/auth_service.dart';
import 'package:food_fly/framework/service/fire_store_service.dart';

import '../utils/theme/theme.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: StreamBuilder<List<NotificationDataModel>>(
        stream: FireStoreService.fireStoreService.getNotificationsFireStore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final notifications = snapshot.data!
                .where((element) =>
                    element.uid ==
                    AuthService.authService.auth.currentUser!.uid)
                .toList();
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notificationModel = notifications[index];
                return NotificationCard(notificationModel: notificationModel);
              },
            );
          }
          return const Center(
            child: Text('No Notifications Found'),
          );
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notificationModel});
  final NotificationDataModel notificationModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.notifications)),
        title: Text(notificationModel.title),
        subtitle: Text(notificationModel.body),
      ),
    );
  }
}
