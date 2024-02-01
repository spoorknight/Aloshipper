import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuple/tuple.dart';

import '../../base/base_view_model.dart';
import '../../data/repositories/authentication_repository.dart';
import '../../di/injection/injection.dart';
import '../../models/list_address_model.dart/address_model.dart';
import '../../models/shared_models/base_model.dart';
import '../../navigator/app_navigator.dart';
import '../../navigator/routes.dart';
import '../../network/api_path.dart';
import '../../network/base_dio.dart';
import '../../shared/show_toast.dart';
import '../../utils/helpers/logger.dart';

enum ImageType { matTruocCCCD, matSauCCCD, matTruocGPLX, matSauGPLX, chanDung }

class RegisterViewModel extends BaseViewModel {
  final AuthenticationRepository authRepo;

  RegisterViewModel({required this.authRepo}) : super() {
    init();
    fullnameController.addListener(checkValidButton);
    usernameController.addListener(checkValidButton);
    passwordController.addListener(checkValidButton);
    password2Controller.addListener(checkValidButton);
    phoneNumberController.addListener(checkValidButton);
    emailController.addListener(checkValidButton);
    licensePlatesCtl.addListener(checkValidButton);
  }

  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController licensePlatesCtl = TextEditingController();
  bool isAgreeRules = false;
  bool isActiveButton = false;
  List<Tuple2<String, String>> driverType = const [
    Tuple2('Xe máy', '1'),
    Tuple2('Ô tô', '2'),
  ];

  List<Tuple2<String, int>> numberSeats = const [
    Tuple2('4 Chỗ', 4),
    Tuple2('7 Chỗ', 7),
  ];
  late List<ImageModel> listImageModel;

  String? selectedType;
  int? selectedNumberSeat;

  AddressSelected? addressSelected = AddressSelected();

  void init() {
    listImageModel = [
      ImageModel(
        title: 'Mặt trước CCCD',
        image: null,
        type: ImageType.matTruocCCCD,
      ),
      ImageModel(
        title: 'Mặt sau CCCD',
        image: null,
        type: ImageType.matSauCCCD,
      ),
      ImageModel(
        title: 'Mặt trước GPLX',
        image: null,
        type: ImageType.matTruocGPLX,
      ),
      ImageModel(
        title: 'Mặt sau GPLX',
        image: null,
        type: ImageType.matSauGPLX,
      ),
      ImageModel(
        title: 'Chân dung',
        image: null,
        type: ImageType.chanDung,
      ),
    ];
  }

  void selectType(String v) {
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
        usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        password2Controller.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        licensePlatesCtl.text.isNotEmpty &&
        (selectedType == null
            ? false
            : selectedType == '1'
                ? true
                : selectedType == '2'
                    ? selectedNumberSeat != null
                    : false) &&
        listImageModel.every((e) => e.image != null) &&
        addressSelected?.fullAddr?.isNotEmpty == true &&
        isAgreeRules) {
      isActiveButton = true;
    } else {
      isActiveButton = false;
    }
    notifyListeners();
  }

  void toggleAgree(bool v) {
    isAgreeRules = !v;
    checkValidButton();
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

  void register() async {
    EasyLoading.show();
    try {
      final dio = await BaseDio.setup();
      List<String?> listBase64Image = [];
      for (var e in listImageModel) {
        if (e.image != null) {
          listBase64Image.add(await convertBase64Image(e.image!));
        }
      }
      Logger.d('LIST IMAGE', listBase64Image.length);
      final data = {
        'tokenlogin': appData.tokenLogin,
        'device_token': appData.firebaseToken,
        'fullname': fullnameController.text,
        'username': usernameController.text,
        'password': passwordController.text,
        'password2': password2Controller.text,
        'phone_number': phoneNumberController.text,
        'address': addressSelected?.fullAddr ?? '',
        'country_id': addressSelected?.province?.id,
        'state_id': addressSelected?.district?.id,
        'city_id': addressSelected?.commune?.id,
        'email': emailController.text,
        'loaixe': selectedType,
        'biensoxe': licensePlatesCtl.text,
        'giayphep[0]': listBase64Image[0],
        'giayphep[1]': listBase64Image[1],
        'giayphep[2]': listBase64Image[2],
        'giayphep[3]': listBase64Image[3],
        'giayphep[4]': listBase64Image[4],
        'sochongoi': selectedNumberSeat,
      };
      BaseModel bm = const BaseModel();
      final res = await dio.post(ApiPath.requestOpenShipper,
          data: FormData.fromMap(data));
      bm = BaseModel.fromJson(res.data);
      if (bm.status == true) {
        EasyLoading.dismiss();
        ShowToast.success(bm.mess ?? bm.item);
        AppNavigator.pushAndRemoveUntil(Routes.loginScreen);
      } else {
        EasyLoading.dismiss();
        ShowToast.error(bm.mess ?? bm.item);
      }
    } catch (e) {
      Logger.d('REGISTER >>>', e);
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }
}

class ImageModel {
  final String title;
  final ImageType type;
  XFile? image;
  String? networkImage;

  ImageModel({
    required this.title,
    required this.type,
    this.image,
    this.networkImage,
  });
}
