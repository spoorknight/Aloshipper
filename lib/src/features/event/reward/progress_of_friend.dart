import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../configs/config.dart';
import '../../../models/event/refer_friend_model.dart';
import '../../../navigator/app_navigator.dart';
import '../../../shared/app_bar.dart';
import '../../../shared/cache_image_network.dart';
import '../../../shared/my_scaffold.dart';
import '../event_view_model.dart';
import '../widgets/rules_widget.dart';

class ProgressOfFriendScreen extends StatelessWidget {
  const ProgressOfFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      bgColor: Palette.newLightGrey,
      padding: EdgeInsets.zero,
      appBar: MyAppBar(
        title: 'Tiến độ của bạn bè',
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios, color: Palette.black),
          onTap: () => AppNavigator.pop(),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 16.w),
        padding: AppTheme.mainPadding,
        color: Palette.white,
        child: Column(
          children: [
            BoxConst.s8,
            Text(
              'Danh sách bạn đã mời',
              style: AppFont.t.s(13).w500.nuatral90,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.w),
              child: const Divider(color: Palette.grey, height: 1),
            ),
            Expanded(
              child: Consumer<EventViewModel>(builder: (context, viewModel, _) {
                return SmartRefresher(
                  controller: viewModel.refreshCtl,
                  enablePullDown: false,
                  onLoading: () {},
                  enablePullUp: false,
                  // enablePullUp: viewModel.isLastPage ? false : true,
                  child: ListView.separated(
                    controller: viewModel.scrollCrl,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: viewModel.lstProgressOfFriends.length,
                    separatorBuilder: (_, i) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.w),
                      child: const Divider(color: Palette.grey, height: 1),
                    ),
                    itemBuilder: (_, i) {
                      ReferFriendModel item = viewModel.lstProgressOfFriends[i];
                      return Row(
                        children: [
                          item.avatar != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20.r),
                                  child: CachedNetworkImageCustom(
                                    url: item.avatar,
                                    boxFit: BoxFit.fitWidth,
                                    width: 34.w,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 16.r,
                                  child: Text(
                                    item.getNameAvatar,
                                    style: AppFont.t.s(16).w500.white,
                                  ),
                                ),
                          BoxConst.s8,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      item.getName,
                                      style: AppFont.t.s(13).w400.black,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3),
                                      child: Icon(
                                        Icons.circle,
                                        size: 6,
                                        color: Palette.nuatral50,
                                      ),
                                    ),
                                    Text(
                                      item.getPhoneNumber,
                                      style: AppFont.t.s(13).w400.nuatral50,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Số lượt xem quảng cáo',
                                      style: AppFont.t.s(13).w300.nuatral50,
                                    ),
                                    Text(
                                      item.getStringAds,
                                      style: AppFont.t.s(13).w300.nuatral50,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Số đơn hàng',
                                      style: AppFont.t.s(13).w300.nuatral50,
                                    ),
                                    Text(
                                      item.getCountOrder,
                                      style: AppFont.t.s(13).w300.nuatral50,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }),
            ),
            BoxConst.s12,
            const RulesWidget(),
          ],
        ),
      ),
    );
  }
}
