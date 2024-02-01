import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../configs/config.dart';
import '../../di/injection/injection.dart';
import '../../models/event/mission_model.dart';
import '../../models/list_service_model.dart';
import '../../models/profile_model.dart';
import '../../navigator/app_navigator.dart';
import '../../shared/app_bar.dart';
import '../../shared/empty.dart';
import '../../shared/loading.dart';
import '../../shared/my_scaffold.dart';
import '../../utils/app_enum.dart';
import '../../widgets/base_button_widget.dart';
import '../../widgets/base_toggle_button.dart';
import '../../widgets/line_painter/line_painter_widget.dart';
import '../../widgets/measure_size_widget.dart';
import '../event/event_view_model.dart';
import '../profile/profile_view_model.dart';
import 'widgets/item_expand.dart';

part 'widgets/info_extend_widget.dart';

part 'widgets/list_extend_widget.dart';

part 'widgets/mission_widget.dart';

class ExtendScreen extends StatelessWidget {
  const ExtendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      bgColor: Palette.newLightGrey,
      padding: EdgeInsets.zero,
      body: Column(
        children: [
          const InfoExtendWidget(),
          BoxConst.s16,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  MissionWidget(),
                  ListExtendWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
