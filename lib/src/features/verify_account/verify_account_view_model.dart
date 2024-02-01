// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:app_shipper/src/data/repositories/profile_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuple/tuple.dart';

import '../../base/base_view_model.dart';
import '../../di/injection/injection.dart';
import '../../models/shared_models/base_model.dart';
import '../../navigator/app_navigator.dart';
import '../../network/api_path.dart';
import '../../network/base_dio.dart';
import '../../shared/show_toast.dart';
import '../../utils/helpers/logger.dart';
import '../register/register_view_model.dart';

class VerifyAccountViewModel extends BaseViewModel {
  final ProfileRepository profileRepo;

  VerifyAccountViewModel({required this.profileRepo}) : super() {
    init();
    fullnameController.addListener(checkValidButton);

    phoneNumberController.addListener(checkValidButton);

    licensePlatesCtl.addListener(checkValidButton);
  }

  final TextEditingController fullnameController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController licensePlatesCtl = TextEditingController();

  bool isActiveButton = false;
  List<Tuple2<String, int>> driverType = const [
    Tuple2('Xe máy', 1),
    Tuple2('Ô tô', 2),
  ];

  List<Tuple2<String, int>> numberSeats = const [
    Tuple2('4 Chỗ', 4),
    Tuple2('7 Chỗ', 7),
  ];
  late List<ImageModel> listImageModel;

  int? selectedType;
  int? selectedNumberSeat;

  void init() {
    final lengthImages =
        appData.profile.valueOrNull?.item?.giaypheps?.length ?? 0;
    final images = appData.profile.valueOrNull?.item?.giaypheps;
    fullnameController.text =
        '${appData.profile.valueOrNull?.item?.user?.firstName ?? ''} ${appData.profile.valueOrNull?.item?.user?.lastName ?? ''}';
    phoneNumberController.text =
        appData.profile.valueOrNull?.item?.user?.phoneNumber ?? '';
    licensePlatesCtl.text =
        appData.profile.valueOrNull?.item?.user?.biensoxe ?? '';
    selectedNumberSeat =
        int.tryParse(appData.profile.valueOrNull?.item?.user?.sochongoi ?? '');
    selectedType =
        int.tryParse(appData.profile.valueOrNull?.item?.user?.loaixe ?? '');

    if (selectedType == 0) {
      selectedType = null;
    }
    listImageModel = [
      ImageModel(
          title: 'Mặt trước CCCD',
          image: null,
          type: ImageType.matTruocCCCD,
          networkImage: lengthImages > 0 ? images![0] : null),
      ImageModel(
          title: 'Mặt sau CCCD',
          image: null,
          type: ImageType.matSauCCCD,
          networkImage: lengthImages > 1 ? images![1] : null),
      ImageModel(
          title: 'Mặt trước GPLX',
          image: null,
          type: ImageType.matTruocGPLX,
          networkImage: lengthImages > 2 ? images![2] : null),
      ImageModel(
          title: 'Mặt sau GPLX',
          image: null,
          type: ImageType.matSauGPLX,
          networkImage: lengthImages > 3 ? images![3] : null),
      ImageModel(
          title: 'Chân dung',
          image: null,
          type: ImageType.chanDung,
          networkImage: lengthImages > 4 ? images![4] : null),
    ];
    checkValidButton();
  }

  void selectType(int v) {
    selectedType = v;
    checkValidButton();
    notifyListeners();
  }

  void selectNumberSeat(int v) {
    selectedNumberSeat = v;
    checkValidButton();
    notifyListeners();
  }

  void checkValidButton() {
    if (fullnameController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        licensePlatesCtl.text.isNotEmpty &&
        (selectedType == null
            ? false
            : selectedType == 1
                ? true
                : selectedType == 2
                    ? selectedNumberSeat != null
                    : false) &&
        (listImageModel.any((e) => e.image != null) ||
            listImageModel.any((e) => e.networkImage != null))) {
      isActiveButton = true;
    } else {
      isActiveButton = false;
    }
    notifyListeners();
  }

  void pickImage(ImageType type) {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        listImageModel.firstWhere((e) => e.type == type).image = value;
        checkValidButton();
        notifyListeners();
      }
    });
  }

  void delete(ImageType type) {
    listImageModel.firstWhere((e) => e.type == type).image = null;
    checkValidButton();
    notifyListeners();
  }

  Future<String?> convertBase64Image(XFile image) async {
    String? base64Image;
    List<int> imageBytes = File(image.path).readAsBytesSync();
    base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  Future<Map<String, dynamic>> _data() async {
    final val = <String, dynamic>{};
    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('giayphep[0]', await toBase64(listImageModel[0].image));
    writeNotNull('giayphep[1]', await toBase64(listImageModel[1].image));
    writeNotNull('giayphep[2]', await toBase64(listImageModel[2].image));
    writeNotNull('giayphep[3]', await toBase64(listImageModel[3].image));
    writeNotNull('giayphep[4]', await toBase64(listImageModel[4].image));
    return val;
  }

  Future<String?> toBase64(XFile? image) async {
    if (image != null) {
      return await convertBase64Image(image);
    }
    return null;
  }

  void register() async {
    EasyLoading.show();
    try {
      final dio = await BaseDio.setup();
      final data = {
        'tokenlogin': appData.tokenLogin,
        'device_token': appData.firebaseToken,
        'fullname': fullnameController.text,
        'phone_number': phoneNumberController.text,
        'loaixe': selectedType,
        'biensoxe': licensePlatesCtl.text,
        'sochongoi': selectedNumberSeat,
      };
      data.addAll(await _data());
      BaseModel baseRes = const BaseModel();
      final res = await dio.post(ApiPath.updateTaiKhoanShipper,
          data: FormData.fromMap(data));
      baseRes = BaseModel.fromJson(res.data);
      if (baseRes.status == true) {
        EasyLoading.dismiss();
        AppNavigator.pop(true);
      } else {
        EasyLoading.dismiss();
        ShowToast.error(baseRes.mess ?? baseRes.item);
      }
    } catch (e) {
      Logger.d('DANG KY >>>', e);
      EasyLoading.dismiss();
    }
  }
}
