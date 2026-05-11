import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/chat_bloc.dart';
import '../../bloc/chat_event.dart';
import '../../../../../core/styles/app_colors.dart';

class CustomInputField extends StatefulWidget {
  final int sessionId;
  const CustomInputField({super.key, required this.sessionId});

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  final TextEditingController controller = TextEditingController();

  bool hasText = false;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        hasText = controller.text.isNotEmpty;
      });
    });
  }

  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    context.read<ChatBloc>().add(
      SendMessageEvent(sessionId: widget.sessionId, text: controller.text),
    );

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Type a message.....",

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),

          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10),

            child: IconButton(
              onPressed: sendMessage,

              icon: Icon(
                hasText ? Icons.send : Icons.emoji_emotions_outlined,

                color: AppColors.primaryDark,
                size: 28,
              ),
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.blue.shade200),
          ),
        ),
      ),
    );
  }
}
