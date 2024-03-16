import 'dart:io';

import 'package:app_shipper/src/data/repositories/profile_repository.dart';
import 'package:app_shipper/src/di/injection/injection.dart';
import 'package:app_shipper/src/features/register/register_view_model.dart';
import 'package:app_shipper/src/features/verify_account/verify_account_view_model.dart';
import 'package:app_shipper/src/features/verify_account/widget/item_image.dart';
import 'package:app_shipper/src/models/user_info/user_info_res.dart';
import 'package:app_shipper/src/shared/address_field/address_field.dart';
import 'package:app_shipper/src/shared/cache_image_network.dart';
import 'package:app_shipper/src/shared/check_box.dart';
import 'package:app_shipper/src/shared/vehicle_field/vehicle_field.dart';
import 'package:app_shipper/src/utils/extensions/context_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../configs/app_constants.dart';
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
      padding: EdgeInsets.zero,
      bgColor: Palette.newLightGrey,
      appBar: const MyAppBar(title: 'Xác thực tài khoản',centerTitle: true),
      body: FutureBuilder<UserInfoVerify?>(
        future: viewModel.futureUserInfo,
        builder: (context, snapshot) {
          if(snapshot.data != null){
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: AppTheme.mainPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BoxConst.s12,
                          Text(
                            'Nhập thông tin tài khoản',
                            style: AppFont.t.s(15).w500,
                          ),
                          BoxConst.h(12),
                          CustomTextFormFieldVerify(
                            title: 'Họ và tên',
                            hintText: 'Họ và tên',
                            controller: viewModel.fullNameController,
                          ),
                          BoxConst.h(16),
                          CustomTextFormFieldVerify(
                            title: 'Email',
                            hintText: 'Email',
                            controller: viewModel.emailController,
                          ),
                          BoxConst.h(16),
                          CustomTextFormFieldVerify(
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
                          AddressFiled(
                            title: 'Địa chỉ',
                            isVerify: true,
                            hintText: 'Địa chỉ',
                            addressSelected: viewModel.addressSelected,
                            profileRepository: getIt<ProfileRepository>(),
                            onComplete: viewModel.checkValidButton,
                          ),
                          BoxConst.h(16),
                          Row(
                            children: [
                              Expanded(
                                child: DropDownCustomVerify(
                                  listTuple: viewModel.driverType,
                                  title: 'Loại xe',
                                  hintText: 'Loại xe',
                                  value: viewModel.selectedType,
                                  onChange: (v) => viewModel.selectType(v),
                                ),
                              ),
                              BoxConst.s8,
                              Expanded(
                                child:CustomTextFormFieldVerify(
                                  title: 'Biển số xe',
                                  hintText: 'Biển số xe',
                                  controller: viewModel.licensePlatesCtl,
                                ),)
                            ],
                          ),
                          if (viewModel.selectedType == 2)
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: DropDownCustomVerify(
                                listTuple: viewModel.numberSeats,
                                title: 'Số chỗ ngồi',
                                hintText: 'Số chỗ ngồi',
                                value: viewModel.selectedNumberSeat,
                                onChange: (v) => viewModel.selectNumberSeat(v),
                              ),
                            ),

                          BoxConst.h(16),
                          VehicleField(
                            title: 'Dòng xe',
                            hintText: 'Dòng xe',
                            vehicleSelected: viewModel.vehicleSelected,
                            profileRepository: getIt<ProfileRepository>(),
                            onComplete: viewModel.checkValidButton,
                          ),
                          BoxConst.s20,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Thông tin cá nhân', style: AppFont.t.s(15).w500,),
                          ),
                          BoxConst.s8,
                          listImage(title: "Ảnh chân dung, CCCD/CMND", list: viewModel.listImageCCCD,viewModel: viewModel),
                          listImage(title: "Giấy phép lái xe, Cavet xe", list: viewModel.listImageGPLX,viewModel: viewModel),
                          listImage(title: "Hình ảnh phương tiện đăng ký", list: viewModel.listImageVehicle,viewModel: viewModel),
                          Row(
                            children: [
                              CheckBoxCustom(
                                isChecked: viewModel.isAgree,
                                onPress: (v) => viewModel.toggleAgree(v),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: 'Tôi đã đọc và đồng ý với ',
                                  style: AppFont.t,
                                  children: [
                                    TextSpan(
                                        text: 'Điều khoản',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            launchUrlString(
                                              AppConstants.linkDieuKhoan,
                                              mode: LaunchMode.externalApplication,
                                            );
                                          },
                                        style: AppFont.t.w700.red),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          BoxConst.h(16),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Palette.white,
                  padding: AppTheme.mainPadding,
                  child: Column(
                    children: [
                      BoxConst.h(10),
                      Text(
                        'Bạn phải cam kết tuân thủ các quy định của pháp luật và các thông tin hoàn toàn là chính xác',
                        style: AppFont.t,
                        textAlign: TextAlign.center,
                      ),
                      BoxConst.h(10),
                      MyButton.rounded(
                        title: 'Gửi xét duyệt',
                        borderRadius: 5,
                        action: viewModel.isActiveButton ? viewModel.register : null,
                      ),
                      BoxConst.h(10),
                    ],
                  ),
                )

              ],
            );
          }else{
            return const SizedBox();
          }
        },
      ),
    );
  }
  
  Widget listImage({required String title,required List<ImageModel> list, required VerifyAccountViewModel viewModel}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title,style: AppFont.t,),
              Text(" *",style: AppFont.t.red,)
            ],
          ),
          BoxConst.s8,
          Wrap(
            spacing: 15.w,
            runSpacing: 15.w,
            children: list
                .map(
                  (e) => ItemImage(
                model: e,
                pickImage: () => viewModel.pickImage(e.type,list),
                onDelete: () => viewModel.delete(e.type,list),),
            )
                .toList(),
          ),
        ],
      ),
    );
  }
}
