class ChatModel {
  ChatModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int senderId;
  final int receiverId;
  final String message;
  final bool isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json["id"],
      senderId: json["sender_id"],
      receiverId: json["receiver_id"],
      message: json["message"],
      isRead: json["is_read"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
