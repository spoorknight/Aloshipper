import 'package:app_shipper/src/shared/dialog.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';

import '../../configs/app_constants.dart';
import '../../configs/config.dart';
import '../../shared/app_bar.dart';
import '../../shared/button.dart';
import '../../shared/cache_image_network.dart';
import '../../shared/my_scaffold.dart';
import '../../shared/show_toast.dart';
import '../payment/payment_view_model.dart';
import 'tourguide_modal.dart';

class PaymentInformationScreen extends StatelessWidget {
  const PaymentInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PaymentViewModel>();
    return MyScaffold(
      bgColor: Palette.newLightGrey,
      padding: EdgeInsets.zero,
      appBar: const MyAppBar(
        title: 'Thông tin chuyển khoản',
        backgroundColor: Palette.white,
      ),
      bottom: Padding(
        padding: AppTheme.mainPadding.copyWith(bottom: paddingBottomButton),
        child: MyButton.rounded(
            title: 'Trở về',
            borderRadius: 8,
            action: () {
              showDialog(
                context: context,
                builder: (builder) {
                  return DialogConfirm(
                    mess:
                        'Bạn đã hoàn thành các bước chuyển khoản của giao dịch này?',
                    title: 'Hoàn thành chuyển khoản',
                    titleButton: 'Đã hoàn thành',
                    cancelButton: 'Chưa hoàn thành',
                    action: () {
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    },
                  );
                },
              );
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BoxConst.s8,
            // Assets.svgs.mbBank.svg(width: 120, fit: BoxFit.fitWidth),
            // Box.s16,
            Container(
              width: double.infinity,
              padding: AppTheme.mainPadding.copyWith(top: 16, bottom: 16),
              decoration: const BoxDecoration(
                color: Palette.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  renderQR(viewModel.imageQR ?? ''),
                  BoxConst.s8,
                  InkWell(
                    onTap: () => saveQR(viewModel.imageQR ?? ''),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Palette.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Tải xuống',
                            style: AppFont.t.s(13).w700.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  BoxConst.s8,
                  renderBaseInfo(viewModel),
                  BoxConst.s8,
                  renderAmount(viewModel),
                  BoxConst.s8,
                  renderDescription(viewModel),
                  BoxConst.s8,
                  Text.rich(
                    TextSpan(
                      text: '*',
                      style: AppFont.t.s(13).w400.red,
                      children: [
                        TextSpan(
                          text:
                              'Lưu ý: Vui lòng giữ nguyên nội dung chuyển khoản. Hệ thống sẽ tự nhận diện thanh toán trong vài giây.',
                          style: AppFont.t.s(13).w400.black,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BoxConst.s16,
            renderNote(context),
            BoxConst.s36,
          ],
        ),
      ),
    );
  }

  Widget renderNote(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.yellowFFE4B9,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: AppTheme.mainPadding,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Assets.svgs.description.svg(width: 60, height: 60),
          BoxConst.s8,
          Expanded(
            child: Column(
              children: [
                Text(
                  'Bạn gặp khó khăn khi nạp tiền? Vui lòng bấm xem hướng dẫn sau',
                  style: AppFont.t.s(13).w400.black,
                ),
                BoxConst.s8,
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return const TourGuideModal();
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        'Xem hướng dẫn',
                        style: AppFont.t.s(13).w400.blue,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 12,
                        color: Palette.blue,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget renderBaseInfo(PaymentViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.whiteEEF2F3,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            viewModel.bankInfo?.data?.bankName ?? '',
            style: AppFont.t.s(13).w700.black,
          ),
          BoxConst.s8,
          rowInfo(
            title: 'Tài khoản',
            value: viewModel.bankInfo?.data?.bankNum ?? '',
            isCopy: true,
          ),
          BoxConst.s8,
          rowInfo(
            title: 'Chủ tài khoản',
            value: viewModel.bankInfo?.data?.accountOwner ?? '',
          ),
        ],
      ),
    );
  }

  Widget renderAmount(PaymentViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.whiteEEF2F3,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rowInfo(
            title: 'Số tiền',
            value: viewModel.amountController.text.toVnd,
            isCopy: true,
          ),
        ],
      ),
    );
  }

  Widget renderDescription(PaymentViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.whiteEEF2F3,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rowInfo(
            title: 'Nội dung chuyển khoản',
            value: viewModel.bankInfo?.data?.getContentPrefix ?? '',
            isCopy: true,
            isRequire: true,
          ),
        ],
      ),
    );
  }

  Widget rowInfo({
    required String title,
    required String value,
    bool isRequire = false,
    bool isCopy = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: title,
                style: AppFont.t.s(13).w500.black,
                children: [
                  if (isRequire)
                    TextSpan(
                      text: ' *',
                      style: AppFont.t.s(13).w500.red,
                    )
                ],
              ),
            ),
            Text(
              value,
              style: AppFont.t.s(13).w700.black,
            ),
          ],
        ),
        if (isCopy)
          InkWell(
            onTap: () async {
              ///value
              await Clipboard.setData(
                ClipboardData(text: value),
              );
              ShowToast.success('Sao chép thành công');
            },
            child: Container(
              decoration: BoxDecoration(
                color: Palette.green,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                'Sao chép',
                style: AppFont.t.s(13).w500.white,
              ),
            ),
          )
      ],
    );
  }

  void saveQR(String url) async {
    try {
      EasyLoading.show();
      final response = await Dio()
          .get(url, options: Options(responseType: ResponseType.bytes));

      final filePath = await ImageGallerySaver.saveImage(
        response.data,
      );
      EasyLoading.show();
      if (filePath != null &&
          filePath.containsKey('isSuccess') &&
          filePath['isSuccess']) {
        EasyLoading.showToast('Tải QR Code thành công');
      }
    } catch (e) {
      EasyLoading.show();
      print('imageId e => $e');
    }
  }

  Widget renderQR(String imageQR) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: CachedNetworkImageCustom(
        url: imageQR,
        boxFit: BoxFit.contain,
        height: 100.h,
        width: 100.w,
      ),
    );
  }
}
