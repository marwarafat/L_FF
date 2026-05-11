import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../../domain/usecases/get_chat_sessions_usecase.dart';
import '../../domain/usecases/get_chat_messages_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../../domain/usecases/mark_message_as_read_usecase.dart';
import '../../../profile/domain/usecases/get_user_profile_usecase.dart';
import '../../data/datasources/chat_remote_data_source.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../../profile/data/datasources/profile_remote_data_source.dart';
import '../../../profile/data/repositories/profile_repository_impl.dart';
import 'widgets/chat_bubble.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;

class FullChatScreen extends StatefulWidget {
  final int sessionId;
  final String otherUserName;
  final String? otherUserImage;

  const FullChatScreen({
    super.key,
    required this.sessionId,
    required this.otherUserName,
    this.otherUserImage,
  });

  @override
  State<FullChatScreen> createState() => _FullChatScreenState();
}

class _FullChatScreenState extends State<FullChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _showEmoji = false;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() {
        _isTyping = _messageController.text.trim().isNotEmpty;
      });
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _showEmoji = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) {
        final chatDataSource = ChatRemoteDataSourceImpl();
        final chatRepository = ChatRepositoryImpl(chatDataSource);

        final profileDataSource = ProfileRemoteDataSourceImpl();
        final profileRepository = ProfileRepositoryImpl(profileDataSource);

        return ChatBloc(
          getChatSessionsUseCase: GetChatSessionsUseCase(chatRepository),
          getChatMessagesUseCase: GetChatMessagesUseCase(chatRepository),
          sendMessageUseCase: SendMessageUseCase(chatRepository),
          markMessageAsReadUseCase: MarkMessageAsReadUseCase(chatRepository),
          getUserProfileUseCase: GetUserProfileUseCase(profileRepository),
        )..add(LoadChatMessagesEvent(widget.sessionId));
      },
      child: BlocBuilder<ChatBloc, ChatState>(
        buildWhen: (previous, current) =>
            current is ChatMessagesLoaded ||
            current is ChatMessagesLoading ||
            current is ChatError,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage:
                        widget.otherUserImage != null &&
                            widget.otherUserImage!.startsWith('http')
                        ? NetworkImage(widget.otherUserImage!)
                        : const AssetImage('assets/icons/profile_fill.png')
                              as ImageProvider,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.otherUserName,
                      style: TextStyle(color: Colors.blue[400], fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Builder(
                    builder: (ctx) {
                      if (state is ChatMessagesLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ChatError) {
                        return Center(
                          child: Text(
                            "${l10n.failed}: ${state.message}",
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (state is ChatMessagesLoaded) {
                        if (state.messages.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.blue.withValues(alpha: 0.2),
                                      width: 2,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 45,
                                    backgroundImage:
                                        widget.otherUserImage != null &&
                                            widget.otherUserImage!.isNotEmpty
                                        ? NetworkImage(widget.otherUserImage!)
                                        : const AssetImage(
                                                'assets/icons/profile_fill.png',
                                              )
                                              as ImageProvider,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  widget.otherUserName,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    l10n.viewProfile,
                                    style: TextStyle(
                                      color: Colors.blue[400],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.messages.length,
                          reverse:
                              true, // Display messages from bottom to top normally, API might return newest last though. If newest last, don't reverse or reverse list
                          itemBuilder: (context, index) {
                            // Assuming API returns newest messages last.
                            // To use reverse: true on ListView, we need newest at index 0.
                            // So we map the index backwards:
                            final msg = state
                                .messages[state.messages.length - 1 - index];
                            final isMe = msg.senderId == state.currentUserId;

                            return ChatBubble(message: msg.text, isMe: isMe);
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Builder(
                    builder: (blocCtx) {
                      return Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              focusNode: _focusNode,
                              decoration: InputDecoration(
                                hintText: l10n.typeMessageHint,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _showEmoji
                                        ? Icons.keyboard
                                        : Icons.emoji_emotions_outlined,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    if (_showEmoji) {
                                      _focusNode.requestFocus();
                                    } else {
                                      _focusNode.unfocus();
                                      setState(() {
                                        _showEmoji = !_showEmoji;
                                      });
                                    }
                                  },
                                ),
                              ),
                              onSubmitted: (value) {
                                if (value.trim().isNotEmpty) {
                                  blocCtx.read<ChatBloc>().add(
                                    SendMessageEvent(
                                      sessionId: widget.sessionId,
                                      text: value.trim(),
                                    ),
                                  );
                                  _messageController.clear();
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (_isTyping)
                            IconButton(
                              icon: const Icon(Icons.send, color: Colors.blue),
                              onPressed: () {
                                final text = _messageController.text.trim();
                                if (text.isNotEmpty) {
                                  blocCtx.read<ChatBloc>().add(
                                    SendMessageEvent(
                                      sessionId: widget.sessionId,
                                      text: text,
                                    ),
                                  );
                                  _messageController.clear();
                                }
                              },
                            ),
                        ],
                      );
                    },
                  ),
                ),
                if (_showEmoji)
                  SizedBox(
                    height: 250,
                    child: EmojiPicker(
                      textEditingController: _messageController,
                      config: Config(
                        height: 250,
                        checkPlatformCompatibility: true,
                        emojiViewConfig: EmojiViewConfig(
                          emojiSizeMax:
                              28 *
                              (foundation.defaultTargetPlatform ==
                                      TargetPlatform.iOS
                                  ? 1.2
                                  : 1.0),
                        ),
                        skinToneConfig: const SkinToneConfig(),
                        categoryViewConfig: const CategoryViewConfig(),
                        bottomActionBarConfig: const BottomActionBarConfig(),
                        searchViewConfig: const SearchViewConfig(),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
