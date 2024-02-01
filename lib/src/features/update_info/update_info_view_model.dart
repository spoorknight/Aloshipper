import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../../base/base_view_model.dart';
import '../../data/repositories/profile_repository.dart';
import '../../di/injection/injection.dart';
import '../../models/list_address_model.dart/address_model.dart';
import '../../models/profile_model.dart';
import '../../navigator/app_navigator.dart';
import '../../shared/show_toast.dart';

class UpdateInfoViewModel extends BaseViewModel {
  final ProfileRepository profileRepo;

  UpdateInfoViewModel({required this.profileRepo}) : super() {
    init();
  }

  TextEditingController fullnameCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  TextEditingController password2Ctl = TextEditingController();
  TextEditingController phoneNumberCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();

  AddressSelected? addressSelected = AddressSelected();

  File? avatar;

  final ProfileModel? profile = appData.profile.valueOrNull;

  void init() {
    fullnameCtl.text =
        '${profile?.item?.user?.firstName} ${profile?.item?.user?.lastName ?? ''}';
    phoneNumberCtl.text = '${profile?.item?.user?.phoneNumber}';
    emailCtl.text = '${profile?.item?.user?.email}';
    if (profile?.item?.user?.address?.split(', ').length == 4) {
      addressSelected = AddressSelected(
        province: AddressModel(
          id: profile?.item?.user?.countryId,
          name: profile?.item?.user?.address?.split(', ')[3],
        ),
        district: AddressModel(
          id: profile?.item?.user?.stateId,
          countryId: profile?.item?.user?.countryId,
          name: profile?.item?.user?.address?.split(', ')[2],
        ),
        commune: AddressModel(
          id: profile?.item?.user?.cityId,
          countryId: profile?.item?.user?.countryId,
          stateId: profile?.item?.user?.stateId,
          name: profile?.item?.user?.address?.split(', ')[1],
        ),
        detailAddr: profile?.item?.user?.address?.split(', ')[0],
        fullAddr: profile?.item?.user?.address,
      );
    }
  }

  void updateInfo() async {
    try {
      String? avatarBase64;
      EasyLoading.show();
      if (avatar != null) {
        avatarBase64 = appData.convertBase64Image(avatar);
      }
      final res = await profileRepo.updateProfile(
        appData.tokenLogin,
        appData.firebaseToken,
        appData.profile.valueOrNull?.item?.user?.username ?? '',
        fullnameCtl.text,
        avatarBase64,
        passwordCtl.text,
        password2Ctl.text,
        phoneNumberCtl.text,
        emailCtl.text,
        addressSelected?.fullAddr,
        addressSelected?.province?.id,
        addressSelected?.district?.id,
        addressSelected?.commune?.id,
      );
      if (res.status == true) {
        AppNavigator.pop(true);
      } else {
        ShowToast.error(res.mess ?? res.item);
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      ShowToast.error('Cập nhật thất bại. Vui lòng thử lại');
    }
  }

  void pickImage() {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        avatar = File(value.path);
        notifyListeners();
      }
    });
  }
}
