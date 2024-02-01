import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'bought_customer_view_model.dart';
import '../../models/list_bought_customer_model/bought_customer.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../configs/config.dart';
import '../../shared/app_bar.dart';
import '../../shared/dropdown.dart';
import '../../shared/empty.dart';
import '../../shared/loading.dart';
import '../../shared/my_scaffold.dart';
import '../../shared/text_form_field.dart';
import '../../utils/extensions/extensions.dart';

class BoughtCustomerScreen extends StatelessWidget {
  const BoughtCustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BoughtCustomerViewModel>();
    return MyScaffold(
      padding: EdgeInsets.zero,
      appBar: const MyAppBar(title: 'Danh sách khách hàng đã mua'),
      body: Column(
        children: [
          BoxConst.s16,
          Padding(
            padding: AppTheme.mainPadding,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Text('Ngày', style: AppFont.t),
                      BoxConst.s8,
                      Expanded(
                        child: CustomTextFormField(
                          controller: viewModel.dateCtl,
                          height: 36,
                          width: context.w() / 3,
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
                  flex: 3,
                  child: Row(
                    children: [
                      Text('Trạng thái', style: AppFont.t),
                      BoxConst.s8,
                      Expanded(
                        child: DropDownTuple2(
                          height: 36,
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
                    child: viewModel.boughtCustomers.isEmpty
                        ? const Empty()
                        : ListView.separated(
                            controller: viewModel.scrollCrl,
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            itemCount: viewModel.boughtCustomers.length,
                            separatorBuilder: (_, i) => const Divider(),
                            itemBuilder: (_, i) => _ItemCustomer(
                              customer: viewModel.boughtCustomers[i],
                            ),
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ItemCustomer extends StatelessWidget {
  final BoughtCustomerModel customer;
  const _ItemCustomer({
    Key? key,
    required this.customer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: 'Khách hàng: #',
                  style: AppFont.t.s(12),
                  children: [
                    TextSpan(
                      text: customer.customer?.phoneNumber?.hide,
                      style: AppFont.t.s(12).red,
                    ),
                  ],
                ),
              ),
              Text(
                'Mua hàng lúc: ${customer.createdAt}',
                style: AppFont.t.s(12).hint,
              ),
              Text.rich(
                TextSpan(
                  text: 'Sản phẩm: ',
                  style: AppFont.t.s(12),
                  children: [
                    TextSpan(
                      text: '${customer.product?.title ?? ''} - ',
                      style: AppFont.t.s(12),
                    ),
                    TextSpan(
                      text: '#${customer.product?.sku}',
                      style: AppFont.t.s(12).yellow,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            customer.statusText ?? '',
            style: AppFont.t.s(12),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '+${customer.hoahong}'.toVnd,
            style: AppFont.t.s(12).green,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
