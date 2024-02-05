import 'package:app_shipper/src/di/injection/injection.dart';
import 'package:app_shipper/src/features/profile/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/event_repository.dart';
import '../collaborate/collaborate.dart';
import '../event/event_view_model.dart';
import '../event/reward/reward_screen.dart';
import '../extend/extend_screen.dart';
import '../payment/payment.dart';
import 'package:flutter/material.dart';

import '../../configs/config.dart';
import '../../shared/my_scaffold.dart';
import '../personal_info/personal_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileViewModel>();
    return StreamBuilder<bool>(
        stream: appData.canPayment,
        builder: (context, canPayment) {
          return DefaultTabController(
            length: canPayment.data == true ? 3 : 2,
            child: MyScaffold(
              padding: EdgeInsets.zero,
              appBar: AppBar(
                shape: const Border(
                    bottom: BorderSide(color: Palette.grey, width: 1)),
                automaticallyImplyLeading: false,
                backgroundColor: Palette.transparent,
                toolbarHeight: 45.h,
                elevation: 0,
                title: TabBar(
                  indicatorColor: Palette.transparent,
                  labelStyle: AppFont.t.underline,
                  unselectedLabelStyle: AppFont.t,
                  labelColor: Palette.red,
                  unselectedLabelColor: Palette.black,
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  tabs: [
                    const Tab(child: Text('Thông tin')),

                    if (canPayment.data == true)
                    const Tab(child: Text('Gói dịch vụ')),
                    // const Tab(child: Text('Hợp tác')),
                    if (canPayment.data == true)
                      const Tab(child: Text('Thanh toán')),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  const PersonalInfo(),

                  if (canPayment.data == true)
                  MultiProvider(
                    providers: [
                      ChangeNotifierProvider.value(
                        value: viewModel,
                      ),
                      ChangeNotifierProvider.value(value: eventViewModel),
                    ],
                    child: const ExtendScreen(),
                  ),
                  // const CollaborateScreen(),
                  if (canPayment.data == true) const Payment(),
                ],
              ),
            ),
          );
        });
  }
}
