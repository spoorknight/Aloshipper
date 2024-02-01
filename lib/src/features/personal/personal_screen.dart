
import 'package:app_shipper/src/features/collaborate/collaborate.dart';

import '../payment/payment.dart';
import 'package:flutter/material.dart';

import '../../configs/config.dart';
import '../../shared/my_scaffold.dart';
import '../personal_info/personal_info.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: MyScaffold(
        padding: EdgeInsets.zero,
        appBar: AppBar(
          shape:
              const Border(bottom: BorderSide(color: Palette.grey, width: 1)),
          automaticallyImplyLeading: false,
          backgroundColor: Palette.transparent,
          elevation: 0,
          title: TabBar(
            indicatorColor: Palette.transparent,
            labelStyle: AppFont.t.underline,
            unselectedLabelStyle: AppFont.t,
            labelColor: Palette.red,
            unselectedLabelColor: Palette.black,
            tabs: const [
              Tab(child: Text('Thông tin')),
              Tab(child: Text('Hợp tác')),
              Tab(child: Text('Thanh toán')),
            ],
          ),
        ),
        body:  const TabBarView(
          children: [
            PersonalInfo(),
            CollaborateScreen(),
            Payment(),
          ],
        ),
      ),
    );
  }
}
