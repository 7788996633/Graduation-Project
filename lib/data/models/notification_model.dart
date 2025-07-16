class NotificationModel {
  NotificationModel({
    required this.id,
    required this.type,
    required this.notifiableType,
    required this.notifiableId,
    required this.title,
    required this.body,
    required this.url,
    required this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String type;
  final String notifiableType;
  final int notifiableId;
  final String title;
  final String body;
  final String url;
  final bool isRead = false;
  final dynamic readAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"],
      type: json["type"],
      notifiableType: json["notifiable_type"],
      notifiableId: json["notifiable_id"],
      title: json["data"]["title"],
      body: json["data"]["body"],
      url: json["data"]["url"],
      readAt: json["read_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
