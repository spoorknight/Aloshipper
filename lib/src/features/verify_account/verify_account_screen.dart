import 'dart:io';

import 'package:app_shipper/src/features/verify_account/verify_account_view_model.dart';
import 'package:app_shipper/src/shared/cache_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../configs/config.dart';
import '../../shared/app_bar.dart';
import '../../shared/button.dart';
import '../../shared/dropdown.dart';
import '../../shared/my_scaffold.dart';
import '../../shared/text_form_field.dart';

class VerifyAccountScreen extends StatelessWidget {
  const VerifyAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<VerifyAccountViewModel>();
    return MyScaffold(
      appBar: const MyAppBar(title: 'Xác thực tài khoản'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BoxConst.h(16),
                  CustomTextFormField(
                    title: 'Họ và tên',
                    hintText: 'Họ và tên',
                    controller: viewModel.fullnameController,
                  ),
                  BoxConst.h(16),
                  CustomTextFormField(
                    title: 'Số điện thoại',
                    hintText: 'Số điện thoại',
                    maxLength: 10,
                    controller: viewModel.phoneNumberController,
                    inputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                  ),
                  BoxConst.h(16),
                  DropDownCustom(
                    listTuple: viewModel.driverType,
                    title: 'Loại xe',
                    hintText: 'Loại xe',
                    value: viewModel.selectedType,
                    onChange: (v) => viewModel.selectType(v),
                  ),
                  if (viewModel.selectedType == 2)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: DropDownCustom(
                        listTuple: viewModel.numberSeats,
                        title: 'Số chỗ ngồi',
                        hintText: 'Số chỗ ngồi',
                        value: viewModel.selectedNumberSeat,
                        onChange: (v) => viewModel.selectNumberSeat(v),
                      ),
                    ),
                  BoxConst.h(16),
                  CustomTextFormField(
                    title: 'Biển số xe',
                    hintText: 'Biển số xe',
                    controller: viewModel.licensePlatesCtl,
                  ),
                  BoxConst.h(16),
                  BoxConst.s8,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Chụp ảnh', style: AppFont.t),
                  ),
                  BoxConst.s8,
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.w,
                    children: viewModel.listImageModel
                        .map(
                          (e) => Stack(
                            children: [
                              SizedBox(
                                width: (1.sw - 64.w) / 5,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () => viewModel.pickImage(e.type),
                                      child: Container(
                                        height: (1.sw - 64.w) / 5,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Palette.grey),
                                        ),
                                        child: Center(
                                          child: e.image != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.file(
                                                      File(e.image!.path),
                                                      fit: BoxFit.cover),
                                                )
                                              : e.networkImage != null
                                                  ? CachedNetworkImageCustom(
                                                      url: e.networkImage,
                                                      borderRadius: 10,
                                                    )
                                                  : const Icon(Icons.camera_alt,
                                                      size: 24),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      e.title,
                                      style: AppFont.t.s(12),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                              if (e.image != null)
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: InkWell(
                                    onTap: () => viewModel.delete(e.type),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Palette.black),
                                      child: const Icon(Icons.close,
                                          color: Palette.white, size: 12),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        )
                        .toList(),
                  ),
                  BoxConst.h(16),
                  Text(
                    'Bạn phải cam kết tuân thủ các quy định của pháp luật và các thông tin hoàn toàn là chính xác',
                    style: AppFont.t,
                    textAlign: TextAlign.center,
                  ),
                  BoxConst.h(20),
                ],
              ),
            ),
          ),
          MyButton.rounded(
            title: 'Gửi duyệt',
            action: viewModel.isActiveButton ? viewModel.register : null,
          ),
          BoxConst.h(20),
        ],
      ),
    );
  }
}
