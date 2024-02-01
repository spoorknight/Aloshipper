import 'package:app_shipper/src/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../configs/config.dart';
import '../../../models/event/store_for_share_model.dart';
import '../../../navigator/app_navigator.dart';
import '../../../shared/app_bar.dart';
import '../../../shared/cache_image_network.dart';
import '../../../shared/loading.dart';
import '../../../shared/my_scaffold.dart';
import '../../../shared/show_toast.dart';
import '../event_view_model.dart';
import '../widgets/custom_event_button.dart';
import '../widgets/rules_widget.dart';

class ListStoresShareScreen extends StatelessWidget {
  const ListStoresShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      bgColor: Palette.newLightGrey,
      appBar: MyAppBar(
        title: 'Chia sẻ cửa hàng',
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios, color: Palette.black),
          onTap: () => AppNavigator.pop(),
        ),
      ),
      body: Column(
        children: [
          BoxConst.s8,
          renderListStore(context),
          BoxConst.s8,
          const RulesWidget(),
        ],
      ),
    );
  }

  Widget renderListStore(BuildContext context) {
    return Expanded(
      child: Container(
        width: context.device.width,
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: const [0.1, 0.5, 0.7, 0.9],
            colors: Palette.bgColorEvent,
          ),
        ),
        child: Consumer<EventViewModel>(builder: (context, viewModel, _) {
          // if (viewModel.shareStore?.checkDisableButton == true) {
          //   Navigator.of(context).pop();
          // }
          return SmartRefresher(
            scrollController: viewModel.scrollStoreCtl,
            controller: viewModel.refreshListStoreCtl,
            onLoading: viewModel.loadMoreStore,
            enablePullUp: viewModel.isLastPageStore ? false : true,
            onRefresh: viewModel.onRefreshStore,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          viewModel.shareTitle,
                          style: AppFont.t.s(16).w500.white,
                        ),
                      ),
                      BoxConst.s12,
                      Assets.svgs.coinWalk.svg(width: 150.w),
                    ],
                  ),
                  BoxConst.s12,
                  Text(
                    'Chia sẻ cửa hàng',
                    style: AppFont.t.s(16).w500.white,
                  ),
                  BoxConst.s8,
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 13.w, horizontal: 13.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: viewModel.isLoading
                        ? const Loading()
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewModel.listStoresForShare.length,
                            itemBuilder: (context, index) {
                              StoreForShareModel item =
                                  viewModel.listStoresForShare[index];
                              return Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(32.r),
                                    child: SizedBox(
                                      width: 48.w,
                                      height: 48.w,
                                      child: CachedNetworkImageCustom(
                                        url: item.avatar,
                                      ),
                                    ),
                                  ),
                                  BoxConst.s8,
                                  Expanded(
                                    child: Text(
                                      item.shopName ?? '',
                                      style: AppFont.t.s(13).w700.nuatral90,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  BoxConst.s8,
                                  CustomEventButton(
                                    txtButton: 'Chia sẻ',
                                    onTap: () async {
                                      if ((item.subdomain ?? '').isEmpty) {
                                        ShowToast.error(
                                            'Không tìm thấy thông tin chia sẻ');
                                        return;
                                      }
                                      await viewModel.shareStoreForMission(
                                          item.subdomain ?? '', item.id);
                                    },
                                  ),
                                ],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.w),
                                child: const Divider(color: Palette.nuatral30),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
