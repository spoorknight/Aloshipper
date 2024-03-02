import 'package:app_shipper/src/features/notifications/notification_news_view.dart';
import 'package:app_shipper/src/features/notifications/notification_order_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../configs/config.dart';
import '../../configs/palette.dart';
import '../../shared/app_bar.dart';
import '../../shared/loading.dart';
import '../../shared/my_scaffold.dart';
import 'notification_view_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> with TickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotificationViewModel>();
    return MyScaffold(
      bgColor: Palette.newLightGrey,
      padding: EdgeInsets.zero,
      appBar: MyAppBar(title: 'Thông báo', backgroundColor: Palette.white,centerTitle: true,
          actions: [
            InkWell(
                onTap: () => _showActionSheet(context,viewModel),
                child: Assets.svgs.icFilter.svg()),
            BoxConst.s12
          ]),
      body: viewModel.isLoading
          ? const Loading()
          : Column(
        children: [
          Container(
            color: Palette.white,
            height: 50,
            child: TabBar(
              labelColor: Palette.black,
              indicatorColor: Palette.black,
              unselectedLabelColor: Palette.grey,
              controller: tabController,
              labelStyle: AppFont.t.s(16).w500,
              tabs:  [
                const Text('Đơn hàng'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Tin tức'),
                    Visibility(
                      visible: viewModel.countUnReadNew > 0,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                            color: Palette.red,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Center(child: Text(viewModel.countUnReadNew.toString(),style: AppFont.t.s(12).white,),),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                NotificationOrderView(viewModel: viewModel),
                NotificationNewsView(viewModel: viewModel)
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showActionSheet(BuildContext context, NotificationViewModel viewModel) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        // title: const Text('Title'),
        // message: const Text('Message'),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child:  Text('Bỏ qua',style: AppFont.t.s(15).blue.w600,),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as delete or exit and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () => viewModel.filterListNews("all"),
            child: const Text('Tất cả'),
          ),
          CupertinoActionSheetAction(
            onPressed: () => viewModel.filterListNews("read"),
            child:  Text('Đã xem',style:AppFont.t.s(15).blue,),),
          CupertinoActionSheetAction(
            onPressed: () => viewModel.filterListNews("unread"),
            child: Text('Chưa xem',style: AppFont.t.s(15).blue),
          ),
        ],
      ),
    );
  }
}
