import 'dart:io';

import 'package:app_shipper/src/shared/text_field/base_text_form_field.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../configs/app_constants.dart';
import '../../data/repositories/profile_repository.dart';
import '../../di/injection/injection.dart';
import '../../shared/address_field/address_field.dart';
import '../../shared/dropdown.dart';
import '../../utils/helpers/validators.dart';
import 'register_view_model.dart';
import '../../navigator/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../configs/config.dart';
import '../../navigator/app_navigator.dart';
import '../../shared/app_bar.dart';
import '../../shared/button.dart';
import '../../shared/check_box.dart';
import '../../shared/my_scaffold.dart';
import '../../shared/text_form_field.dart';
import '../../utils/extensions/extensions.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RegisterViewModel>();
    return MyScaffold(
      bgColor: Palette.newLightGrey,
      appBar: const MyAppBar(title: 'Đăng ký',centerTitle: true),
      body: SingleChildScrollView(
        // child: Column(
        //   children: [
        //     BoxConst.s24,
        //     Text(
        //       'Nhập thông tin tài khoản',
        //       style: AppFont.t.s(18),
        //     ),
        //     BoxConst.s20,
        //     CustomTextFormField(
        //       title: 'Tên thành viên',
        //       hintText: 'Tên thành viên',
        //       controller: viewModel.usernameController,
        //     ),
        //     BoxConst.s16,
        //     CustomTextFormField(
        //       title: 'Họ và tên',
        //       hintText: 'Họ và tên',
        //       controller: viewModel.fullnameController,
        //     ),
        //     BoxConst.s16,
        //     CustomTextFormField(
        //       title: 'Số điện thoại',
        //       hintText: 'Số điện thoại',
        //       maxLength: 10,
        //       controller: viewModel.phoneNumberController,
        //       inputType: TextInputType.number,
        //       inputFormatters: [
        //         FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
        //       ],
        //     ),
        //     BoxConst.s16,
        //     AddressFiled(
        //       title: 'Địa chỉ',
        //       hintText: 'Địa chỉ',
        //       addressSelected: viewModel.addressSelected,
        //       profileRepository: getIt<ProfileRepository>(),
        //       onComplete: viewModel.checkValidButton,
        //     ),
        //     BoxConst.s16,
        //     CustomTextFormField(
        //       title: 'Email',
        //       hintText: 'Email',
        //       controller: viewModel.emailController,
        //     ),
        //     BoxConst.s16,
        //     DropDownCustom(
        //       listTuple: viewModel.driverType,
        //       title: 'Loại xe',
        //       hintText: 'Loại xe',
        //       value: viewModel.selectedType,
        //       onChange: (v) => viewModel.selectType(v),
        //     ),
        //     if (viewModel.selectedType == '2')
        //       Padding(
        //         padding: EdgeInsets.only(top: 16.h),
        //         child: DropDownCustom(
        //           listTuple: viewModel.numberSeats,
        //           title: 'Số chỗ ngồi',
        //           hintText: 'Số chỗ ngồi',
        //           value: viewModel.selectedNumberSeat,
        //           onChange: (v) => viewModel.selectNumberSeat(v),
        //         ),
        //       ),
        //     BoxConst.h(16),
        //     CustomTextFormField(
        //       title: 'Biển số xe',
        //       hintText: 'Biển số xe',
        //       controller: viewModel.licensePlatesCtl,
        //     ),
        //     BoxConst.s16,
        //     CustomTextFormField(
        //       isPassword: true,
        //       title: 'Mật khẩu',
        //       hintText: 'Mật khẩu',
        //       controller: viewModel.passwordController,
        //     ),
        //     BoxConst.s16,
        //     CustomTextFormField(
        //       isPassword: true,
        //       title: 'Xác nhận mật khẩu',
        //       hintText: 'Xác nhận mật khẩu',
        //       controller: viewModel.password2Controller,
        //     ),
        //     BoxConst.s16,
        //     Align(
        //       alignment: Alignment.centerLeft,
        //       child: Text('Chụp ảnh', style: AppFont.t),
        //     ),
        //     BoxConst.s8,
        //     Wrap(
        //       spacing: 8.w,
        //       runSpacing: 8.w,
        //       children: viewModel.listImageModel
        //           .map(
        //             (e) => Stack(
        //               children: [
        //                 SizedBox(
        //                   width: (1.sw - 64.w) / 5,
        //                   child: Column(
        //                     mainAxisSize: MainAxisSize.min,
        //                     children: [
        //                       InkWell(
        //                         onTap: () => viewModel.pickImage(e.type),
        //                         child: Container(
        //                           height: (1.sw - 64.w) / 5,
        //                           decoration: BoxDecoration(
        //                             borderRadius: BorderRadius.circular(10),
        //                             border: Border.all(color: Palette.grey),
        //                           ),
        //                           child: Center(
        //                             child: e.image != null
        //                                 ? Image.file(File(e.image!.path),
        //                                     fit: BoxFit.cover)
        //                                 : const Icon(Icons.camera_alt,
        //                                     size: 24),
        //                           ),
        //                         ),
        //                       ),
        //                       Text(
        //                         e.title,
        //                         style: AppFont.t.s(12),
        //                         textAlign: TextAlign.center,
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //                 if (e.image != null)
        //                   Positioned(
        //                     right: 0,
        //                     top: 0,
        //                     child: InkWell(
        //                       onTap: () => viewModel.delete(e.type),
        //                       child: Container(
        //                         decoration:
        //                             const BoxDecoration(color: Palette.black),
        //                         child: const Icon(Icons.close,
        //                             color: Palette.white, size: 12),
        //                       ),
        //                     ),
        //                   )
        //               ],
        //             ),
        //           )
        //           .toList(),
        //     ),
        //     BoxConst.s16,
        //     Text(
        //       'Bạn phải cam kết tuân thủ các quy định của pháp luật và các thông tin hoàn toàn là chính xác',
        //       style: AppFont.t,
        //       textAlign: TextAlign.center,
        //     ),
        //     BoxConst.s16,
        //     Row(
        //       children: [
        //         CheckBoxCustom(
        //           isChecked: viewModel.isAgreeRules,
        //           onPress: (v) => viewModel.toggleAgree(v),
        //         ),
        //         Text.rich(
        //           TextSpan(
        //             text: 'Tôi đã đọc và đồng ý với ',
        //             style: AppFont.t,
        //             children: [
        //               TextSpan(
        //                   text: 'Điều khoản',
        //                   recognizer: TapGestureRecognizer()
        //                     ..onTap = () {
        //                       launchUrlString(
        //                         AppConstants.linkDieuKhoan,
        //                         mode: LaunchMode.externalApplication,
        //                       );
        //                     },
        //                   style: AppFont.t.w700),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //     BoxConst.s16,
        //     MyButton.rounded(
        //       title: 'Đăng ký',
        //       width: context.w() * 0.6,
        //       action:
        //           viewModel.isActiveButton ? () => viewModel.register() : null,
        //     ),
        //     BoxConst.s16,
        //     Text.rich(
        //       TextSpan(
        //         text: 'Bạn đã có tài khoản? ',
        //         style: AppFont.t,
        //         children: [
        //           TextSpan(
        //               text: 'Đăng nhập',
        //               recognizer: TapGestureRecognizer()
        //                 ..onTap = () =>
        //                     AppNavigator.pushAndRemoveUntil(Routes.loginScreen),
        //               style: AppFont.t.w700.red),
        //         ],
        //       ),
        //     ),
        //     BoxConst.s24,
        //   ],
        // ),
        child: Column(
          children: [
            BoxConst.s24,
            Text(
              'Nhập thông tin tài khoản',
              style: AppFont.t.s(18),
            ),
            BoxConst.s20,
            BaseTextFormField(
              title: 'Họ và tên',
              hintText: 'Họ và tên',
              controller: viewModel.fullnameController,
            ),
            BoxConst.s16,
            BaseTextFormField(
              title: 'Số điện thoại',
              hintText: 'Số điện thoại',
              prefixIcon: Icon(
                Icons.smartphone_outlined,
                color: Palette.grey,
                size: 18.sp,
              ),
              controller: viewModel.phoneNumberController,
              inputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
              validator: (text) {
                if(Validator.isValidPhoneNumber(text ?? "")){
                  return null;
                }
                return 'Số điện thoại không hợp lệ';
              },
            ),
            BoxConst.s16,
            BaseTextFormField(
              isPassword: true,
              title: 'Mật khẩu',
              hintText: 'Mật khẩu',
              controller: viewModel.passwordController,
              validator: (text) {
                if(text != null && text.isNotEmpty){
                  return null;
                }
                return 'Mật khẩu không thể bỏ trống';
              },
            ),
            BoxConst.s16,
            BaseTextFormField(
              isPassword: true,
              title: 'Xác nhận mật khẩu',
              hintText: 'Xác nhận mật khẩu',
              controller: viewModel.password2Controller,
              validator: (text) {
                if(text != null && text.isNotEmpty){
                  return null;
                }
                return 'Mật khẩu không thể bỏ trống';
              },
            ),
            BoxConst.s16,
            BaseTextFormField(
              title: 'Mã giới thiệu',
              hintText: 'Nhập mã giới thiệu',
              controller: viewModel.codeInventController,
            ),
            BoxConst.s16,
            Row(
              children: [
                CheckBoxCustom(
                  isChecked: viewModel.isAgreeRules,
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
            BoxConst.s16,
            MyButton.rounded(
              title: 'Đăng ký',
              borderRadius: 8.r,
              width: 255.w,
              color: Palette.primary,
              action:
              viewModel.isActiveButton ? () => viewModel.register() : null,
            ),
            BoxConst.s16,
            Text.rich(
              TextSpan(
                text: 'Bạn đã có tài khoản? ',
                style: AppFont.t,
                children: [
                  TextSpan(
                    text: 'Đăng nhập',
                    recognizer: TapGestureRecognizer()
                      ..onTap = AppNavigator.pop,
                    style: AppFont.t.w700.red,
                  ),
                ],
              ),
            ),
            BoxConst.s24,
          ],
        ),

      ),
    );
  }
}
