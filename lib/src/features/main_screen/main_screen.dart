import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../configs/config.dart';
import '../../di/injection/injection.dart';
import '../../shared/my_scaffold.dart';
import '../notifications/notifications_screen.dart';
import '../order/views/order_screen.dart';
import '../profile/profile_screen.dart';
import '../profile/profile_view_model.dart';
import '../statistic/statistic.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _widgetOptions = [
    const OrderScreen(),
    const Statistic(),
    const NotificationsScreen(),
    // const ProfileScreen(),
    const ProfileScreen()
  ];

  int _selectedTab = 0;

  void _selectTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  void initState() {
    super.initState();
    appData.checkUpdate(context);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      padding: EdgeInsets.zero,
      bgColor: Palette.newLightGrey,
      body: _widgetOptions.elementAt(_selectedTab),
      bottom: _bottomNavigation(),
    );
  }

  Widget _bottomNavigation() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        backgroundBlendMode: BlendMode.clear,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Assets.svgs.menu.shopping.svg(
                  width: 20, height: 20, color: Palette.iconMenuHomeUnSelect),
              activeIcon: Assets.svgs.menu.shopping
                  .svg(width: 20, height: 20, color: Palette.primary),
              label: 'Đơn hàng',
            ),
            BottomNavigationBarItem(
              icon: Assets.svgs.menu.expensive.svg(
                  width: 20, height: 20, color: Palette.iconMenuHomeUnSelect),
              activeIcon: Assets.svgs.menu.expensive
                  .svg(width: 20, height: 20, color: Palette.primary),
              label: 'Thống kê',
            ),
            BottomNavigationBarItem(
              icon: Assets.svgs.menu.bell.svg(
                  width: 20, height: 20, color: Palette.iconMenuHomeUnSelect),
              activeIcon: Assets.svgs.menu.bell
                  .svg(width: 20, height: 20, color: Palette.primary),
              label: 'Thông báo',
            ),
            BottomNavigationBarItem(
              icon: Assets.svgs.menu.profile.svg(
                  width: 20, height: 20, color: Palette.iconMenuHomeUnSelect),
              activeIcon: Assets.svgs.menu.profile
                  .svg(width: 20, height: 20, color: Palette.primary),
              label: 'Tài khoản',
            ),
          ],
          elevation: 0,
          currentIndex: _selectedTab,
          selectedItemColor: Palette.red,
          unselectedItemColor: Palette.black,
          selectedFontSize: 14.sp,
          unselectedFontSize: 12.sp,
          backgroundColor: Palette.white,
          onTap: _selectTab,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
