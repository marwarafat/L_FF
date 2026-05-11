import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String image;
  final VoidCallback onTap;

  const MessageItem({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            CircleAvatar(radius: 30, backgroundImage: AssetImage(image)),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  Row(
                    children: [
                      Expanded(
                        child: Text(message, overflow: TextOverflow.ellipsis),
                      ),
                      Text(time),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
