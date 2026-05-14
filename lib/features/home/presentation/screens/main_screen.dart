import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_navigation_bar.dart';
import '../../../../features/home/presentation/cubit/main/main_cubit.dart';
import '../../../../features/home/presentation/screens/home_screen.dart';
import '../../../../features/map/presentation/screens/map_view_screen.dart';
import '../../../../features/profile/presentation/view/profile_screen.dart';
import '../../../../features/chat/presentation/view/chat_list_screen.dart';
import '../../../../features/report/presentation/view/report_item_view.dart';
import '../../../../l10n/app_localizations.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static final List<Widget> _screens = [
    const HomeScreen(),
    const MapViewScreen(),
    const ReportItemView(),
    const ProfileScreen(),
    const ChatListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainCubit(),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Scaffold(
            
            extendBody: false,
            body: SafeArea(
              bottom: false, // Don't add safety space at bottom because we have a floating nav bar
              child: IndexedStack(
                index: state.selectedIndex,
                children: _screens,
              ),
            ),
            bottomNavigationBar: CustomNavigationBar(
              currentIndex: state.selectedIndex,
              onTap: context.read<MainCubit>().selectTab,
            ),
          );
        },
      ),
    );
  }
}
