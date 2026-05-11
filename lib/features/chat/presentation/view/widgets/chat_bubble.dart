import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      // يمين لو أنا المرسل، يسار لو الطرف الآخر
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        constraints: BoxConstraints(
          maxWidth:
              MediaQuery.of(context).size.width * 0.7, // أقصى عرض 70% من الشاشة
        ),
        decoration: BoxDecoration(
          color: isMe
              ? const Color(0xFF1B85D6)
              : Colors.white, // اللون الأزرق أو الأبيض
          border: isMe
              ? null
              : Border.all(
                  color: Colors.blue.shade200,
                  width: 1,
                ), // إطار أزرق خفيف للأبيض
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            // الزاوية السفلية تكون حادة جهة صاحب الرسالة
            bottomLeft: isMe
                ? const Radius.circular(20)
                : const Radius.circular(0),
            bottomRight: isMe
                ? const Radius.circular(0)
                : const Radius.circular(20),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black87,
            fontSize: 15,
            height: 1.2, // تباعد الأسطر لراحة العين
          ),
        ),
      ),
    );
  }
}
