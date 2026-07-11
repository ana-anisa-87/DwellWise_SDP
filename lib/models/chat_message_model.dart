/// Data model representing an instant message between tenant and owner.
class ChatMessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String message;
  final String? attachmentUrl;
  final bool isRead;
  final DateTime createdAt;

  ChatMessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.message,
    this.attachmentUrl,
    required this.isRead,
    required this.createdAt,
  });

  /// Factory constructor to parse ChatMessageModel from JSON.
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String,
      chatId: json['chat_id'] as String,
      senderId: json['sender_id'] as String,
      message: json['message'] as String? ?? '',
      attachmentUrl: json['attachment_url'] as String?,
      isRead: json['is_read'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  /// Converts ChatMessageModel to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chat_id': chatId,
      'sender_id': senderId,
      'message': message,
      'attachment_url': attachmentUrl,
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
