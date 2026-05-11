import 'package:flutter/material.dart';

class CustomChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final dynamic chat; // تمرير الـ Model الخاص بالشات

  const CustomChatAppBar({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0, // إلغاء الظل ليكون مسطحاً تماماً كما في الصورة
      leadingWidth: 40, // تقليل المساحة الجانبية للسهم
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new, // أيقونة الـ iOS كما يظهر في التصميم
          color: Colors.black,
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0, // إلغاء المسافة التلقائية ليبدأ المحتوى فوراً بعد السهم
      title: Row(
        children: [
          // الصورة الدائرية الصغيرة للمستخدم
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(chat.imageUrl),
            backgroundColor: Colors.grey.shade200,
          ),
          const SizedBox(width: 12),
          // اسم المستخدم باللون الأزرق وخط رفيع (Serif style)
          Text(
            chat.name,
            style: const TextStyle(
              color: Color(0xFF2196F3), // درجة الأزرق الموجودة في النصوص
              fontSize: 18,
              fontWeight: FontWeight.w400,
              fontFamily: 'Serif', // إذا كنتِ تستخدمين خطاً مخصصاً
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
