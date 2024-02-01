import 'package:app_shipper/src/models/profile_model.dart';

import '../../data/repositories/profile_repository.dart';
import '../../di/injection/injection.dart';
import '../../shared/cache_image_network.dart';
import 'update_info_view_model.dart';
import '../../shared/app_bar.dart';
import '../../shared/address_field/address_field.dart';
import '../../shared/my_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../configs/config.dart';
import '../../shared/button.dart';
import '../../shared/text_form_field.dart';

class UpdateInfoScreen extends StatelessWidget {
  const UpdateInfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UpdateInfoViewModel>();

    return MyScaffold(
      appBar: const MyAppBar(title: 'Cập nhật tài khoản'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BoxConst.s16,
            InkWell(
              onTap: viewModel.pickImage,
              child: ClipOval(
                child: Container(
                  width: 70.h,
                  height: 70.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: viewModel.avatar != null
                      ? Image.file(viewModel.avatar!, fit: BoxFit.cover)
                      : viewModel.profile?.item?.userAvatar != null
                          ? CachedNetworkImageCustom(
                              url: viewModel.profile?.item?.userAvatar,
                            )
                          : const Icon(Icons.person, size: 30),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Tên đăng nhập',
                      style: AppFont.t,
                    ),
                  ),
                  StreamBuilder<ProfileModel?>(
                    stream: appData.profile,
                    builder: (context, profile) {
                      return Expanded(
                        child: Text(
                          profile.data?.item?.user?.username ?? '',
                          style: AppFont.t,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
            const Divider(color: Palette.grey),
            BoxConst.s24,
            CustomTextFormField(
              title: 'Họ và tên',
              hintText: 'Họ và tên',
              controller: viewModel.fullnameCtl,
            ),
            BoxConst.s16,
            CustomTextFormField(
              title: 'Số điện thoại',
              hintText: 'Số điện thoại',
              inputType: TextInputType.number,
              controller: viewModel.phoneNumberCtl,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
            ),
            BoxConst.s16,
            AddressFiled(
              title: 'Địa chỉ',
              hintText: 'Địa chỉ',
              addressSelected: viewModel.addressSelected,
              profileRepository: getIt<ProfileRepository>(),
            ),
            BoxConst.s16,
            CustomTextFormField(
              title: 'Email',
              hintText: 'Email',
              controller: viewModel.emailCtl,
            ),
            BoxConst.s16,
            CustomTextFormField(
              isPassword: true,
              title: 'Mật khẩu',
              hintText: 'Mật khẩu',
              controller: viewModel.passwordCtl,
            ),
            BoxConst.s16,
            CustomTextFormField(
              isPassword: true,
              title: 'Xác nhận mật khẩu',
              hintText: 'Xác nhận mật khẩu',
              controller: viewModel.password2Ctl,
            ),
            BoxConst.s16,
            BoxConst.size(50),
            MyButton.rounded(
              title: 'Xác nhận',
              action: viewModel.updateInfo,
            ),
            BoxConst.s20,
          ],
        ),
      ),
    );
  }
}
