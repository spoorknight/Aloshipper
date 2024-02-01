import 'dart:async';

import 'package:app_shipper/src/base/base_view_model.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../configs/app_constants.dart';
import '../../data/repositories/profile_repository.dart';
import '../../di/injection/injection.dart';
import '../../models/bank_info.dart';
import '../../models/bank_model.dart';
import '../../models/user_bank_account_model.dart';
import '../../navigator/app_navigator.dart';
import '../../shared/show_toast.dart';
import '../../utils/app_enum.dart';
import '../../utils/helpers/logger.dart';
import '../../utils/utils.dart';
import '../profile/profile_view_model.dart';

class PaymentViewModel extends BaseViewModel with WidgetsBindingObserver {
  final ProfileRepository profileRepo;

  PaymentViewModel({
    required this.profileRepo,
  }) : super() {
    WidgetsBinding.instance.addObserver(this);
  }

  final soTienQREC = TextEditingController();
  final soTienVnpayEC = TextEditingController();
  final soTienCkEC = TextEditingController();
  final nameEC = TextEditingController();
  final accNumberNumberEC = TextEditingController();
  final bankNameEC = TextEditingController();
  final idQuanEC = TextEditingController();
  final soTienMatEC = TextEditingController();
  final passRutTienEC = TextEditingController();

  final amountController = TextEditingController();
  PaymentDeposit paymentDeposit = PaymentDeposit.transfer;

  String? imageQR;
  BankInfo? bankInfo;
  FocusNode soTienQrNode = FocusNode();

  UserBankAccountModel? userBankAccountModel;
  List<BankModel> lstBanks = [];
  List<BankModel> lstBanksSearch = [];
  BankModel? bankSelected;
  final accountNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  List<String> lstAmount = ['500000', '1000000', '2000000'];

  String get getAccountName => accountNameController.text;

  String get getAccountNumber => accountNumberController.text;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        Logger.d('AppLifecycleState', 'Resumed');
        await getIt<ProfileViewModel>().getProfile();
        break;
      case AppLifecycleState.paused:
        Logger.d('AppLifecycleState', 'Paused');

        break;
      default:
        break;
    }
  }

  setBankNeedEdit(BankAccount? data) {
    try {
      if (data == null) {
        accountNameController.text = '';
        accountNumberController.text = '';
        bankSelected = null;
      } else {
        accountNameController.text = data.getUserBankName ?? '';
        accountNumberController.text = data.getUserBankNumber ?? '';
        bankSelected =
            lstBanks.firstWhere((element) => element.id == data.bankId);
      }
      notifyListeners();
    } catch (e) {}
  }

  setBankSelected(BankModel? data) {
    bankSelected = data;
    notifyListeners();
  }

  Future<void> getUserBanksInfo() async {
    try {
      EasyLoading.show();
      final res = await profileRepo.getUserBanksInfo(appData.tokenLogin);
      if (res.status == true) {
        userBankAccountModel = res;
      }
    } catch (e) {
      Logger.d('getUserBanksInfo error', e);
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  Future<void> getBanks() async {
    try {
      EasyLoading.show();
      final res = await profileRepo.getBanks();
      if (res.status == true) {
        lstBanks = res.data ?? [];
        lstBanksSearch = res.data ?? [];
      }
    } catch (e) {
      Logger.d('getBanks error', e);
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  onSearchBanks(String text) {
    if (text.isNotEmpty) {
      lstBanksSearch =
          lstBanks.fold([], (List<BankModel> filteredList, BankModel element) {
        String shortName = element.getShortName.toLowerCase().unSign();
        String name = element.getName.toLowerCase().unSign();
        String searchText = text.toLowerCase().unSign();

        if (shortName.contains(searchText) || name.contains(searchText)) {
          filteredList.add(element);
        }

        return filteredList;
      });
    } else {
      lstBanksSearch = lstBanks;
    }
    notifyListeners();
  }

  Future<void> submitBankAccount() async {
    try {
      if (getAccountName.isEmpty ||
          getAccountNumber.isEmpty ||
          bankSelected == null) {
        ShowToast.error('Vui lòng nhập đầy đủ thông tin');
      } else {
        EasyLoading.show();
        final res = await profileRepo.createOrUpdate(
          appData.tokenLogin,
          bankSelected!.id ?? '',
          getAccountName.trim(),
          getAccountNumber.trim(),
        );
        EasyLoading.dismiss();
        if (res.status == true) {
          ShowToast.success(res.mess ?? 'Thành công');
          AppNavigator.pop(true);
        } else {
          ShowToast.error(res.mess ?? 'Có lỗi xảy ra!! Vui lòng thử lại');
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      Logger.d('submitBankAccount error', e);
    }
  }

  onChangeDepositMethod(PaymentDeposit value) {
    paymentDeposit = value;
    notifyListeners();
  }

  Timer? timer;

  handleOnChanged(String value, Function() callBack) {
    if (timer != null) {
      timer!.cancel();
    }

    timer = Timer(const Duration(milliseconds: 500), callBack);
  }

  onChangeTextAmount(String? text) {
    try {
      handleOnChanged(text ?? '', () {
        if (text != null && text.isNotEmpty) {
          List<String> newLstAmount =
          Utils().generateSuggestAmountList(n: int.tryParse(text) ?? 0);
          lstAmount = newLstAmount;
        } else {
          lstAmount = ['500000', '1000000', '2000000'];
        }
        notifyListeners();
      });
    } catch (e) {}

    amountController.value = text?.formatNumber.formatTextControllerAmount();
  }

  onSelectAmount(String e) {
    List<String> newLstAmount =
    Utils().generateSuggestAmountList(n: int.tryParse(e) ?? 0);
    lstAmount = newLstAmount;

    amountController.value = e.formatNumber.formatTextControllerAmount();
    notifyListeners();
  }

  void napTien({String? amount}) async {
    EasyLoading.show();
    try {
      final res = await profileRepo.napTien(appData.tokenLogin,
          appData.firebaseToken, amount ?? soTienVnpayEC.text.removeComma);
      if (res.status == true) {
        if (res.url != null) {
          EasyLoading.dismiss();
          await launchUrlString(
            res.url!,
            mode: LaunchMode.externalApplication,
          ).then((_) async {
            await getIt<ProfileViewModel>().getProfile();
          });
        } else {
          EasyLoading.dismiss();
          ShowToast.error(res.mess ?? res.item ?? '');
        }
      } else {
        EasyLoading.dismiss();
        ShowToast.error(res.mess ?? res.item ?? '');
      }
    } catch (e) {
      Logger.d('NAP TIEN >>>', e);
      ShowToast.error('Có lỗi xảy ra, vui lòng thử lại sau');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<bool> rutTienmat() async {
    EasyLoading.show();
    try {
      final res = await profileRepo.rutTienMat(
        appData.tokenLogin,
        appData.firebaseToken,
        idQuanEC.text,
        soTienMatEC.text.removeComma,
        passRutTienEC.text,
      );
      if (res.status == true) {
        EasyLoading.dismiss();
        idQuanEC.clear();
        soTienMatEC.clear();
        passRutTienEC.clear();
        await getIt<ProfileViewModel>().getProfile();
        return true;
      } else {
        EasyLoading.dismiss();
        ShowToast.error(res.mess ?? 'Có lỗi xảy ra, vui lòng thử lại sau');
        return false;
      }
    } catch (e) {
      EasyLoading.dismiss();
      Logger.d('RUT TIEN >>>', e);
      ShowToast.error('Có lỗi xảy ra, vui lòng thử lại sau');
      return false;
    }
  }

  Future<bool> rutTienChuyenKhoan() async {
    EasyLoading.show();
    try {
      final res = await profileRepo.rutTienChuyenKhoan(
        appData.tokenLogin,
        appData.firebaseToken,
        soTienCkEC.text.removeComma,
        accNumberNumberEC.text,
        nameEC.text,
        bankNameEC.text,
      );

      if (res.status == true) {
        EasyLoading.dismiss();
        soTienCkEC.clear();
        accNumberNumberEC.clear();
        nameEC.clear();
        bankNameEC.clear();
        await getIt<ProfileViewModel>().getProfile();
        return true;
      } else {
        EasyLoading.dismiss();
        ShowToast.error(res.mess ?? 'Có lỗi xảy ra, vui lòng thử lại sau');
        return false;
      }
    } catch (e) {
      Logger.d('RUT TIEN CHUYEN KHOAN >>>', e);
      ShowToast.error('Có lỗi xảy ra, vui lòng thử lại sau');
      return false;
    }
  }

  Future scanQR() async {
    try {
      String qrResult = await FlutterBarcodeScanner.scanBarcode(
          "#004297", "Cancel", true, ScanMode.BARCODE);
      idQuanEC.text = qrResult;
      notifyListeners();
    } on PlatformException catch (ex) {
      ShowToast.error("Unknown Error $ex");
    } on FormatException {
      ShowToast.error("You pressed the back button before scanning anything");
    } catch (ex) {
      ShowToast.error("Unknown Error $ex");
    }
  }

  void clear() {
    idQuanEC.clear();
    soTienMatEC.clear();
    passRutTienEC.clear();
    soTienCkEC.clear();
    accNumberNumberEC.clear();
    nameEC.clear();
    bankNameEC.clear();
  }

  void clearECnapTien() {
    soTienQREC.clear();
    soTienVnpayEC.clear();
    bankInfo = null;
    imageQR = null;
  }

  void getInfoPayment({String? amount}) async {
    ///nạp tiền bằng chuyển khoản
    EasyLoading.show();
    amountController.value =
        (amount ?? '0').formatNumber.formatTextControllerAmount();
    final res = await profileRepo.getBankInfo();
    if (res.success == true) {
      bankInfo = res;
      soTienQrNode.unfocus();
      imageQR =
      'https://qr.sepay.vn/img?acc=${bankInfo?.data?.bankNum}&bank=${bankInfo?.data?.bankName}&amount=${amount ?? soTienQREC.text.removeComma}&des=${bankInfo?.data?.getContentPrefix}';
      Logger.d('QR Code', imageQR);
    } else {
      ShowToast.error(res.message);
    }
    EasyLoading.dismiss();
    notifyListeners();
  }

  Future<bool> checkPassword(String inputPassword) async {
    String password = dataManager.getString(AppConstants.password);
    if (inputPassword.trim() == password.trim()) {
      return true;
    }
    return false;
  }
}
