import '../../domain/entities/chat_session_entity.dart';
import '../../domain/entities/chat_message_entity.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSessionsLoading extends ChatState {}

class ChatSessionsLoaded extends ChatState {
  final List<ChatSessionEntity> sessions;
  ChatSessionsLoaded(this.sessions);
}

class ChatMessagesLoading extends ChatState {}

class ChatMessagesLoaded extends ChatState {
  final List<ChatMessageEntity> messages;
  final int currentUserId; // Used to determine if message is sent by me
  final int sessionId;
  ChatMessagesLoaded({
    required this.messages,
    required this.currentUserId,
    required this.sessionId,
  });
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}

class SessionOpenedState extends ChatState {
  final int sessionId;
  SessionOpenedState(this.sessionId);
}
