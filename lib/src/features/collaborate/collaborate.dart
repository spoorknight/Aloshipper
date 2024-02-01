import 'package:app_shipper/src/di/injection/injection.dart';

import '../../shared/app_bar.dart';
import '../../shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../navigator/app_navigator.dart';
import '../../navigator/routes.dart';
import 'package:flutter/material.dart';

import '../../configs/config.dart';
import '../../shared/my_scaffold.dart';
import '../../shared/my_separator.dart';
import '../../shared/text_content/row_content.dart';
import '../../utils/extensions/extensions.dart';
import '../profile/widgets/chevron_right_button.dart';
import 'collaborate_view_model.dart';

class CollaborateScreen extends StatelessWidget {
  const CollaborateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CollaborateViewModel>();
    return MyScaffold(
      appBar: MyAppBar(
        title: 'Hợp tác',
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios, color: Palette.black),
          onTap: () => AppNavigator.pop(),
        ),
      ),
      body: viewModel.isLoading
          ? const Loading()
          : SmartRefresher(
              controller: viewModel.refreshCtl,
              onRefresh: viewModel.onRefresh,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ChevronRightButton(
                    title: 'Điều khoản hợp tác',
                    onTap: () => launchUrlString(
                      viewModel.collaborateInfo?.item?.linkDieukhoan ?? '',
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                  const Divider(color: Palette.grey, height: 1),
                  Padding(
                    padding: AppTheme.mainPadding,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Giới thiệu Store mới',
                            style: AppFont.t.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            launchUrlString(
                              appData.profile.valueOrNull?.item?.profileUrl ??
                                  '',
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          icon: const Icon(Icons.share),
                        )
                      ],
                    ),
                  ),
                  const Divider(color: Palette.grey, height: 1),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Thu nhập', style: AppFont.t),
                        Text('${viewModel.collaborateInfo?.item?.hoahong}',
                            style: AppFont.t.red),
                        Text(
                            '${viewModel.collaborateInfo?.item?.thunhapMoshop ?? 0}'
                                .toVnd,
                            style: AppFont.t.success),
                      ],
                    ),
                  ),
                  const MySeparator(color: Palette.grey),
                  Padding(
                    padding: AppTheme.mainPadding,
                    child: RowContent(
                      title: 'Mã giới thiệu',
                      content: viewModel.collaborateInfo?.item?.maGioiThieu,
                      styleContent: AppFont.t.red,
                    ),
                  ),
                  const MySeparator(color: Palette.grey),
                  InkWell(
                    onTap: () => launchUrlString(
                      viewModel.collaborateInfo?.item?.linkGioiThieu ?? '',
                      mode: LaunchMode.externalApplication,
                    ),
                    child: Padding(
                        padding: AppTheme.mainPadding,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Link giới thiệu',
                                style: AppFont.t.red,
                              ),
                            ),
                            const Icon(Icons.chevron_right,
                                color: Palette.grey),

                            // Expanded(
                            //   flex: 3,
                            //   child: InkWell(
                            //     onTap: () => launchUrlString(
                            //       viewModel.collaborateInfo?.item?.linkGioiThieu ?? '',
                            //       mode: LaunchMode.externalNonBrowserApplication,
                            //     ),
                            //     child: Text(
                            //       viewModel.collaborateInfo?.item?.linkGioiThieu ?? '',
                            //       textAlign: TextAlign.right,
                            //       style: AppFont.t.red,
                            //     ),
                            //   ),
                            // ),
                          ],
                        )),
                  ),
                  BoxConst.s8,
                  const MySeparator(color: Palette.grey, height: 1),
                  ChevronRightButton(
                    title: 'Store đã được giới thiệu',
                    onTap: () {
                      AppNavigator.push(Routes.recommendStore);
                    },
                  ),
                  const Divider(color: Palette.grey, height: 1),
                  BoxConst.s8,
                  Padding(
                    padding: AppTheme.mainPadding,
                    child: Text(
                      'Cộng tác viên bán hàng',
                      style: AppFont.t.red,
                    ),
                  ),
                  BoxConst.s8,
                  const Divider(color: Palette.grey, height: 1),
                  BoxConst.s8,
                  Padding(
                    padding: AppTheme.mainPadding,
                    child: RowContent(
                      title: 'Thu nhập',
                      content:
                          '${viewModel.collaborateInfo?.item?.hoahongSanpham ?? 0}'
                              .toVnd,
                      styleContent: AppFont.t.green,
                    ),
                  ),
                  BoxConst.s8,
                  const MySeparator(color: Palette.grey, height: 1),
                  ChevronRightButton(
                    title: 'Danh sách sản phẩm',
                    onTap: () {
                      AppNavigator.push(Routes.discountProduct);
                    },
                  ),
                  const MySeparator(color: Palette.grey, height: 1),
                  ChevronRightButton(
                    title: 'Khách hàng đã mua',
                    onTap: () {
                      AppNavigator.push(Routes.boughtCustomer);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
