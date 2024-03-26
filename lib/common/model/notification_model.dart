class NotificationDataModel {
  final String id;
  final String title;
  final String body;
  final String uid;
  final String dateTime;

  NotificationDataModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.uid,
      required this.dateTime});

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) {
    return NotificationDataModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        body: json['body'] ?? '',
        uid: json['uid'] ?? '',
        dateTime: json['dateTime'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'uid': uid,
      'dateTime': dateTime
    };
  }
}
