import 'package:flutter/material.dart';
import '../models/chat_message_model.dart';

/// Provider handling instant messaging conversations and attachment uploads.
class ChatProvider with ChangeNotifier {
  final List<ChatMessageModel> _activeMessages = [];
  bool _isTyping = false;

  List<ChatMessageModel> get activeMessages => _activeMessages;
  bool get isTyping => _isTyping;

  /// Loads conversation logs for matching room ID.
  void loadChatHistory(String chatId) {
    _activeMessages.clear();
    // Load stubs
    _activeMessages.addAll([
      ChatMessageModel(
        id: 'm1',
        chatId: chatId,
        senderId: 'tenant1',
        message: 'Hello, is this penthouse available for visit this Friday?',
        isRead: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      ChatMessageModel(
        id: 'm2',
        chatId: chatId,
        senderId: 'owner1',
        message: 'Assalamu Alaikum! Yes, it is. I can show you the flat around 10 AM.',
        isRead: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
    ]);
    notifyListeners();
  }

  /// Appends user message.
  void sendMessage(String chatId, String senderId, String text, {String? attachmentUrl}) {
    final message = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      chatId: chatId,
      senderId: senderId,
      message: text,
      attachmentUrl: attachmentUrl,
      isRead: false,
      createdAt: DateTime.now(),
    );
    _activeMessages.add(message);
    notifyListeners();

    // Trigger typing suggestion response simulation
    _simulateOwnerResponse(chatId);
  }

  void _simulateOwnerResponse(String chatId) async {
    _isTyping = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isTyping = false;
    final message = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      chatId: chatId,
      senderId: 'owner1',
      message: 'Sure, I have attached the flat outline map below.',
      attachmentUrl: 'Gulshan_Penthouse_FloorPlan.pdf',
      isRead: false,
      createdAt: DateTime.now(),
    );
    _activeMessages.add(message);
    notifyListeners();
  }
}
