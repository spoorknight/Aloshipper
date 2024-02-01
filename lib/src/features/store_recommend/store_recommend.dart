import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../configs/config.dart';
import '../../models/list_store_recommend_model/list_store_recommend_model.dart';
import '../../shared/app_bar.dart';
import '../../shared/dropdown.dart';
import '../../shared/empty.dart';
import '../../shared/loading.dart';
import '../../shared/my_scaffold.dart';
import '../../shared/text_form_field.dart';
import '../../utils/extensions/extensions.dart';
import 'store_recommend_view_model.dart';

class StoreRecommendScreen extends StatelessWidget {
  const StoreRecommendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StoreRecommendViewModel>();
    return MyScaffold(
      padding: EdgeInsets.zero,
      appBar: const MyAppBar(title: 'Danh sách store'),
      body: Column(
        children: [
          BoxConst.s16,
          Padding(
            padding: AppTheme.mainPadding,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      BoxConst.s8,
                      Expanded(
                        child: CustomTextFormField(
                          controller: viewModel.dateCtl,
                          height: 36,
                          hintText: "Ngày",
                          readOnly: true,
                          onTap: () {
                            DatePicker.showDatePicker(
                              context,
                              currentTime: viewModel.date ?? DateTime.now(),
                              locale: LocaleType.vi,
                              onConfirm: viewModel.selectDate,
                              minTime: DateTime(1900, 1, 1),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                BoxConst.s12,
                Expanded(
                  child: DropDownTuple2(
                    height: 36,
                    hintText: 'Trạng thái',
                    isBorder: true,
                    isExpanded: true,
                    listItem: viewModel.listStatus,
                    value: viewModel.selectedStatus,
                    onChange: viewModel.onChangeStatus,
                  ),
                )
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: viewModel.isLoading
                ? const Loading()
                : SmartRefresher(
                    controller: viewModel.refreshCtl,
                    onLoading: () => viewModel.loadMore(),
                    enablePullUp: viewModel.isLastPage ? false : true,
                    onRefresh: () => viewModel.onRefresh(),
                    child: viewModel.listStoreRecommend.isEmpty
                        ? const Empty()
                        : ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            itemCount: viewModel.listStoreRecommend.length,
                            separatorBuilder: (_, i) => const Divider(),
                            itemBuilder: (_, i) => _ItemStore(
                              storeRecommend: viewModel.listStoreRecommend[i],
                            ),
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ItemStore extends StatelessWidget {
  final StoreRecommendModel storeRecommend;
  const _ItemStore({
    Key? key,
    required this.storeRecommend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: 'Store: ',
                  style: AppFont.t,
                  children: [
                    TextSpan(
                      text: storeRecommend.shopName,
                      style: AppFont.t.red,
                    ),
                  ],
                ),
              ),
              if (storeRecommend.giahanAt != null)
                Text(
                  'Gia hạn lúc:\n${storeRecommend.giahanAt}',
                  style: AppFont.t.s(12).hint,
                ),
              if (storeRecommend.createdAt != null)
                Text(
                  'Đăng ký lúc:\n${storeRecommend.createdAt}',
                  style: AppFont.t.s(12).hint,
                ),
            ],
          ),
        ),
        Expanded(
          child: Text(
            storeRecommend.statusText ?? '',
            style: AppFont.t.green,
            textAlign: TextAlign.end,
          ),
        ),
        Expanded(
          child: Text(
            '${storeRecommend.totalHoahong}'.toVnd,
            style: AppFont.t.green,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
