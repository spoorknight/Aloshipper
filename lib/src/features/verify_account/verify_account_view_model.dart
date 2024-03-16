// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:app_shipper/src/data/repositories/profile_repository.dart';
import 'package:app_shipper/src/models/list_address_model.dart/address_model.dart';
import 'package:app_shipper/src/models/user_info/user_info_res.dart';
import 'package:app_shipper/src/models/vehicle_model/vehicle_model_by_brand.dart';
import 'package:app_shipper/src/models/vehicle_model/vehicle_selected.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuple/tuple.dart';

import '../../base/base_view_model.dart';
import '../../di/injection/injection.dart';
import '../../models/shared_models/base_model.dart';
import '../../models/vehicle_model/vehilce_brand_model.dart';
import '../../navigator/app_navigator.dart';
import '../../network/api_path.dart';
import '../../network/base_dio.dart';
import '../../shared/show_toast.dart';
import '../../utils/helpers/logger.dart';
import '../register/register_view_model.dart';

class VerifyAccountViewModel extends BaseViewModel {
  final ProfileRepository profileRepo;

  VerifyAccountViewModel({required this.profileRepo}) : super() {
    fullNameController.addListener(checkValidButton);

    phoneNumberController.addListener(checkValidButton);
    emailController.addListener(checkValidButton);

    licensePlatesCtl.addListener(checkValidButton);
    futureUserInfo = getUserInfo();
  }

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController licensePlatesCtl = TextEditingController();
  // final TextEditingController typeVehicleController = TextEditingController();

  AddressSelected? addressSelected = AddressSelected();
  VehicleSelected? vehicleSelected = VehicleSelected();

  bool isActiveButton = false;
  bool isAgree = false;
  List<Tuple2<String, int>> driverType = const [
    Tuple2('Xe máy', 1),
    Tuple2('Ô tô', 2),
  ];

  List<Tuple2<String, int>> numberSeats = const [
    Tuple2('4 Chỗ', 4),
    Tuple2('7 Chỗ', 7),
    Tuple2('9 Chỗ', 9),
  ];
  late List<ImageModel> listImageCCCD = [];
  late List<ImageModel> listImageGPLX  = [];
  late List<ImageModel> listImageVehicle  = [];

  int? selectedType;
  int? selectedNumberSeat;

  Future<UserInfoVerify?>? futureUserInfo;
  UserInfoRes? userInfo;

  Future<UserInfoVerify?> getUserInfo() async {
    userInfo = await profileRepo.getUserInfo();
    if(userInfo?.userInfo != null){
      initData();
      return userInfo?.userInfo;
    }
    return null;
  }

  Future initData() async {
      fullNameController.text = userInfo?.userInfo?.firstName ?? '';
      licensePlatesCtl.text = userInfo?.userInfo?.biensoxe ?? '';
      phoneNumberController.text = userInfo?.userInfo?.phoneNumber ?? '';
      emailController.text = userInfo?.userInfo?.email ?? '';
      selectedNumberSeat = int.parse(userInfo?.userInfo?.sochongoi ?? '0');
      selectedType = int.parse(userInfo?.userInfo?.loaixe ?? '0');
      if (selectedType == 0) {
        selectedType = null;
      }
      addressSelected = AddressSelected(
        province: AddressModel(
          id: userInfo?.userInfo?.provinceId,
          name: userInfo?.userInfo?.provinceName,
        ),
        district: AddressModel(
          id: userInfo?.userInfo?.districtId,
          countryId: userInfo?.userInfo?.provinceId,
          name: userInfo?.userInfo?.districtName
        ),
        commune: AddressModel(
          id: userInfo?.userInfo?.wardId,
          countryId: userInfo?.userInfo?.provinceId,
          stateId:  userInfo?.userInfo?.districtId,
          name: userInfo?.userInfo?.wardName,
        ),
        detailAddr: userInfo?.userInfo?.address,
        fullAddr: '${userInfo?.userInfo?.address}, ${userInfo?.userInfo?.wardName}, ${userInfo?.userInfo?.districtName}, ${userInfo?.userInfo?.provinceName}',
      );

      vehicleSelected = VehicleSelected(
        vehicleBrand: VehicleBrand(
          id: userInfo?.userInfo?.vehicleBrandId,
          name: userInfo?.userInfo?.vehicleBrandName
        ),
        vehicleModel: VehicleModel(
          id: userInfo?.userInfo?.vehicleModelId,
          name: userInfo?.userInfo?.vehicleModelName
        ),
        vehicleYear: userInfo?.userInfo?.vehicleYear,
        fullVehicle: '${userInfo?.userInfo?.vehicleBrandName} | ${userInfo?.userInfo?.vehicleModelName} | ${userInfo?.userInfo?.vehicleYear}'
      );

      listImageCCCD = [
        ImageModel(
            title: 'Ảnh chân dung',
            image: null,
            type: ImageType.chanDung,
            networkImage:userInfo?.userPersonalImages?[0].portrait == null ? null :  "${userInfo?.imgPrefix}${userInfo?.userPersonalImages?[0].portrait}"),
        ImageModel(
            title: 'Mặt trước CCCD',
            image: null,
            type: ImageType.matTruocCCCD,
            networkImage:userInfo?.userPersonalImages?[0].cCCDFront == null ? null :  "${userInfo?.imgPrefix}${userInfo?.userPersonalImages?[0].cCCDFront}"),
        ImageModel(
            title: 'Mặt sau CCCD',
            image: null,
            type: ImageType.matSauCCCD,
            networkImage:userInfo?.userPersonalImages?[0].cCCDBack == null ? null : "${userInfo?.imgPrefix}${userInfo?.userPersonalImages?[0].cCCDBack}"),
      ];

      listImageGPLX = [
        ImageModel(
            title: 'GPLX mặt trước',
            image: null,
            type: ImageType.matTruocGPLX,
            networkImage:userInfo?.userPersonalImages?[0].drivingLicenseFront == null ? null : "${userInfo?.imgPrefix}${userInfo?.userPersonalImages?[0].drivingLicenseFront}"),
        ImageModel(
            title: 'GPLX mặt sau',
            image: null,
            type: ImageType.matSauGPLX,
            networkImage:userInfo?.userPersonalImages?[0].drivingLicenseBack == null ? null :  "${userInfo?.imgPrefix}${userInfo?.userPersonalImages?[0].drivingLicenseBack}"),
        ImageModel(
            title: 'Cavet xe mặt trước',
            image: null,
            type: ImageType.matTruocCavet,
            networkImage:userInfo?.userPersonalImages?[0].vehicleRegistrationCertificateFront == null ? null :  "${userInfo?.imgPrefix}${userInfo?.userPersonalImages?[0].vehicleRegistrationCertificateFront}"),
        ImageModel(
            title: 'Cavet xe mặt sau',
            image: null,
            type: ImageType.matSauCavet,
            networkImage:userInfo?.userPersonalImages?[0].vehicleRegistrationCertificateBack == null ? null :   "${userInfo?.imgPrefix}${userInfo?.userPersonalImages?[0].vehicleRegistrationCertificateBack}"),
      ];

      listImageVehicle = [
        ImageModel(
            title: 'Ảnh phía trước xe',
            image: null,
            type: ImageType.phiaTruocXe,
            networkImage:userInfo?.userPersonalImages?[0].vehicleFront == null ? null : "${userInfo?.imgPrefix}${userInfo?.userPersonalImages?[0].vehicleFront}"),
        ImageModel(
            title: 'Bên phải xe',
            image: null,
            type: ImageType.benPhaiXe,
            networkImage:userInfo?.userPersonalImages?[0].vehicleRight == null ? null : "${userInfo?.imgPrefix}${userInfo?.userPersonalImages?[0].vehicleRight}"),
        ImageModel(
            title: 'Bên trái xe',
            image: null,
            type: ImageType.benTraiXe,
            networkImage:userInfo?.userPersonalImages?[0].vehicleLeft == null ? null : "${userInfo?.imgPrefix}${userInfo?.userPersonalImages?[0].vehicleLeft}"),
        ImageModel(
            title: 'Biển số xe',
            image: null,
            type: ImageType.bienSoXe,
            networkImage:userInfo?.userPersonalImages?[0].vehicleNumberPlate == null ? null : "${userInfo?.imgPrefix}${userInfo?.userPersonalImages?[0].vehicleNumberPlate}"),
      ];

   
      checkValidButton();

  }

  void selectType(int v) {
    selectedType = v;
    if(selectedNumberSeat == 0)selectedNumberSeat = 4;
    checkValidButton();
    notifyListeners();
  }

  void selectNumberSeat(int v) {
    selectedNumberSeat = v;
    checkValidButton();
    notifyListeners();
  }

  void toggleAgree(bool v) {
    isAgree = !v;
    checkValidButton();
    notifyListeners();
  }

  void checkValidButton() {

    if (fullNameController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        licensePlatesCtl.text.isNotEmpty &&
        (selectedType == null
            ? false
            : selectedType == 1
                ? true
                : selectedType == 2
                    ? selectedNumberSeat != null
                    : false) &&
        (listImageCCCD.any((e) => e.image != null) ||
            listImageCCCD.any((e) => e.networkImage != null)) &&
        (listImageGPLX.any((e) => e.image != null) ||
            listImageGPLX.any((e) => e.networkImage != null)) &&
        (listImageVehicle.any((e) => e.image != null) ||
            listImageVehicle.any((e) => e.networkImage != null)) &&
        addressSelected?.fullAddr?.isNotEmpty == true &&
        vehicleSelected?.fullVehicle?.isNotEmpty == true &&
        isAgree
    ) {
      isActiveButton = true;
    } else {
      isActiveButton = false;
    }
    notifyListeners();
  }

  void pickImage(ImageType type, List<ImageModel> list) {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        list.firstWhere((e) => e.type == type).image = value;
        checkValidButton();
        notifyListeners();
      }
    });
  }

  void delete(ImageType type,List<ImageModel> list) {
    list.firstWhere((e) => e.type == type).image = null;
    checkValidButton();
    notifyListeners();
  }

  //
  // Future<String?> convertBase64Image(XFile image) async {
  //   String? base64Image;
  //   List<int> imageBytes = File(image.path).readAsBytesSync();
  //   base64Image = base64Encode(imageBytes);
  //   return base64Image;
  // }

  Future<Map<String, dynamic>> _data() async {
    final val = <String, dynamic>{};
    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('portrait', await toMultiPartFile(listImageCCCD[0].image));
    writeNotNull('CCCD_front', await toMultiPartFile(listImageCCCD[1].image));
    writeNotNull('CCCD_back', await toMultiPartFile(listImageCCCD[2].image));


    writeNotNull('driving_license_front', await toMultiPartFile(listImageGPLX[0].image));
    writeNotNull('driving_license_back', await toMultiPartFile(listImageGPLX[1].image));
    writeNotNull('vehicle_registration_certificate_front', await toMultiPartFile(listImageGPLX[3].image));
    writeNotNull('vehicle_registration_certificate_back', await toMultiPartFile(listImageGPLX[4].image));


    writeNotNull('vehicle_front', await toMultiPartFile(listImageVehicle[0].image));
    writeNotNull('vehicle_right', await toMultiPartFile(listImageVehicle[1].image));
    writeNotNull('vehicle_left', await toMultiPartFile(listImageVehicle[2].image));
    writeNotNull('vehicle_number_plate_img', await toMultiPartFile(listImageVehicle[3].image));

    return val;
  }

  Future<MultipartFile?> toMultiPartFile(XFile? image) async {
    if (image != null) {
      return await MultipartFile.fromFile(image.path, filename: image.path.split('/').last,);
    }
    return null;
  }

  void register() async {
    EasyLoading.show();
    try {
      final dio = await BaseDio.setup();
      final data = {
        'token': appData.tokenLogin,
        'device_token': appData.firebaseToken,
        'fullname': fullNameController.text,
        'email': emailController.text,
        'phone_number': phoneNumberController.text,
        'address': addressSelected?.fullAddr ?? "",
        'province_id': addressSelected?.province?.id,
        'district_id': addressSelected?.district?.id,
        'ward_id': addressSelected?.commune?.id,
        'vehicle_type': selectedType,
        'vehicle_number_plate': licensePlatesCtl.text,
        'number_of_seats': selectedNumberSeat,
        'vehicle_brand_id': vehicleSelected?.vehicleBrand?.id,
        'vehicle_model_id': vehicleSelected?.vehicleModel?.id,
        'vehicle_year': vehicleSelected?.vehicleYear,
      };
      data.addAll(await _data());
      BaseModel baseRes = const BaseModel();
      final res = await dio.post(ApiPath.updateShipperInfo,
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
