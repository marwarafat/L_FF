import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_chat_sessions_usecase.dart';
import '../../domain/usecases/get_chat_messages_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../../domain/usecases/mark_message_as_read_usecase.dart';
import '../../../profile/domain/usecases/get_user_profile_usecase.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatSessionsUseCase getChatSessionsUseCase;
  final GetChatMessagesUseCase getChatMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final MarkMessageAsReadUseCase markMessageAsReadUseCase;
  final GetUserProfileUseCase getUserProfileUseCase;

  int? currentUserId;

  ChatBloc({
    required this.getChatSessionsUseCase,
    required this.getChatMessagesUseCase,
    required this.sendMessageUseCase,
    required this.markMessageAsReadUseCase,
    required this.getUserProfileUseCase,
  }) : super(ChatInitial()) {
    on<LoadChatSessionsEvent>((event, emit) async {
      emit(ChatSessionsLoading());
      try {
        final sessions = await getChatSessionsUseCase();
        emit(ChatSessionsLoaded(sessions));
      } catch (e) {
        emit(ChatError(e.toString()));
      }
    });

    on<LoadChatMessagesEvent>((event, emit) async {
      emit(ChatMessagesLoading());
      try {
        if (currentUserId == null) {
          final profile = await getUserProfileUseCase();
          currentUserId = profile.id;
        }

        final messages = await getChatMessagesUseCase(event.sessionId);

        // Mark unread messages as read
        for (var msg in messages) {
          if (!msg.isRead && msg.receiverId == currentUserId) {
            markMessageAsReadUseCase(msg.id);
          }
        }

        emit(
          ChatMessagesLoaded(
            messages: messages,
            currentUserId: currentUserId!,
            sessionId: event.sessionId,
          ),
        );
      } catch (e) {
        emit(ChatError(e.toString()));
      }
    });

    on<SendMessageEvent>((event, emit) async {
      if (state is ChatMessagesLoaded) {
        final currentState = state as ChatMessagesLoaded;
        try {
          final newMessage = await sendMessageUseCase(
            event.sessionId,
            event.text,
          );
          final updatedMessages = List.of(currentState.messages)
            ..add(newMessage);
          emit(
            ChatMessagesLoaded(
              messages: updatedMessages,
              currentUserId: currentState.currentUserId,
              sessionId: currentState.sessionId,
            ),
          );
        } catch (e) {
          emit(ChatError(e.toString()));
          // Re-emit previous state to keep messages visible
          emit(currentState);
        }
      }
    });
  }
}
