import 'dart:io';

import 'package:app_shipper/src/utils/helpers/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../configs/config.dart';
import '../../../di/injection/injection.dart';
import '../../../shared/app_bar.dart';
import '../../../shared/cache_image_network.dart';
import '../../../shared/dialog.dart';
import '../../../utils/permission_helper/app_permission.dart';

class QRDetail extends StatefulWidget {
  const QRDetail({super.key, required this.url});

  final String? url;

  @override
  State<QRDetail> createState() => _QRDetailState();
}

class _QRDetailState extends State<QRDetail> {
  void showDialogOpenAppSettings() {
    showDialog(
      context: context,
      builder: (builder) {
        return const DialogConfirm(
          titleButton: 'Cho phép',
          mess:
              'Chưa cấp quyền truy cập bộ nhớ cho tính năng này\nVui lòng kiểm tra lại và cấp quyền truy cập vào bộ nhớ cho ứng dụng',
          action: openAppSettings,
        );
      },
    );
  }

  void saveQR() async {
    try {
      EasyLoading.show();
      final response = await Dio().get(widget.url ?? '',
          options: Options(responseType: ResponseType.bytes));

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'QR Code',
        actions: [
          IconButton(
            onPressed: () async {
              Logger.d('Adroid Version', appData.deviceInfo?.os);
              if (Platform.isAndroid &&
                  (double.tryParse(appData.deviceInfo?.os ?? '0') ?? 0) >= 10) {
                saveQR();
              } else {
                GrantPermissionPhotosStrategy().request(
                  onGranted: saveQR,
                  onDenied: showDialogOpenAppSettings,
                  onPermanentlyDenied: showDialogOpenAppSettings,
                );
              }
            },
            icon: const Icon(
              Icons.file_download_outlined,
              color: Palette.black,
            ),
          )
        ],
      ),
      body: Center(
        child: CachedNetworkImageCustom(
          borderRadius: 8,
          url: widget.url,
        ),
      ),
    );
  }
}
