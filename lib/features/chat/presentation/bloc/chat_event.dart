abstract class ChatEvent {}

class LoadChatSessionsEvent extends ChatEvent {}

class LoadChatMessagesEvent extends ChatEvent {
  final int sessionId;
  LoadChatMessagesEvent(this.sessionId);
}

class SendMessageEvent extends ChatEvent {
  final int sessionId;
  final String text;
  SendMessageEvent({required this.sessionId, required this.text});
}

class OpenOrCreateSessionEvent extends ChatEvent {
  final int otherUserId;
  OpenOrCreateSessionEvent(this.otherUserId);
}
