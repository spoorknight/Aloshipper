import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../configs/app_constants.dart';
import '../../navigator/app_navigator.dart';
import '../../navigator/routes.dart';
import '../../utils/helpers/validators.dart';
import '../../widgets/base_button_widget.dart';
import 'forget_password_view_model.dart';
import 'package:provider/provider.dart';

import '../../utils/extensions/extensions.dart';
import '../../configs/config.dart';
import '../../shared/app_bar.dart';
import '../../shared/button.dart';
import '../../shared/my_scaffold.dart';
import '../../shared/text_field/text_form_field.dart';

part 'widgets/forgot_by_email.dart';

part 'widgets/forgot_by_phone.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: MyScaffold(
        appBar: const MyAppBar(title: 'Quên mật khẩu'),
        body: Column(
          children: [
            renderTabBar(),
            BoxConst.s4,
            renderBody(),
          ],
        ),
      ),
    );
  }

  Widget renderTabBar() {
    return Container(
      color: Palette.white,
      child: TabBar(
        indicatorColor: Palette.nuatral90,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 12.w),
        labelStyle: AppFont.t.s(13).w500,
        unselectedLabelStyle: AppFont.t.s(13).w500,
        labelColor: Palette.nuatral90,
        unselectedLabelColor: Palette.nuatral90,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        tabs: const [
          Tab(
            child: Text(
              'Sử dụng SĐT',
            ),
          ),
          Tab(
            child: Text(
              'Sử dụng Email',
            ),
          ),
        ],
      ),
    );
  }

  Widget renderBody() {
    return const Expanded(
      child: TabBarView(
        children: [
          ForgotByPhone(),
          ForgotByEmail(),
        ],
      ),
    );
  }
}
