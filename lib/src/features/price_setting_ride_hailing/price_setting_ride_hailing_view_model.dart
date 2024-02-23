import 'dart:convert';

import 'package:app_shipper/src/base/base_view_model.dart';
import 'package:app_shipper/src/data/repositories/profile_repository.dart';
import 'package:app_shipper/src/di/injection/injection.dart';
import 'package:app_shipper/src/features/price_setting_ride_hailing/price_setting_dto.dart';
import 'package:app_shipper/src/models/price_setting_ride_hailing_model/ride_hailing_setting_model.dart';
import 'package:app_shipper/src/navigator/app_navigator.dart';
import 'package:app_shipper/src/shared/show_toast.dart';
import 'package:app_shipper/src/shared/text_form_field.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:app_shipper/src/utils/helpers/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../configs/config.dart';

class PriceSettingRideHailingViewModel extends BaseViewModel{
  final ProfileRepository profileRepo;

  PriceSettingRideHailingViewModel({required this.profileRepo}) : super() {
    getData();
  }

  List<Widget> widgetForm = [];
  List<PriceSetting> listData = [];

  Future getData() async {
    setLoading = true;
    try{
    final res = await profileRepo.getRideHailingSetting(appData.tokenLogin,);
    if(res.status == true){
      listData.addAll(res.data ?? []);
      widgetForm.add(getForms(listData));
    }else{
      ShowToast.error(res.mess);
    }
    } catch (e) {
      Logger.d('GET RIDE HAILING SETTING >>>', e);
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;


  Widget getForms(List<PriceSetting> models){
    return Wrap(
      spacing: 15,
      runSpacing: 20,
      children: models.map((e) =>   Padding(
        padding: AppTheme.mainPadding,
        child: CustomTextFormField(
          title: e.title,
          hintText: 'Nhập giá cước mong muốn',
          controller: e.edtController,
          inputType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
          ],
          autovalidateMode: autoValidateMode,
          errorText: "Giá cước không thuộc khoảng cho phép",
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Giá cước không được để trống';
            }
            if(!(int.parse(value.removeComma) >= int.parse(e.minPrice??"0") && int.parse(value.removeComma) <= int.parse(e.maxPrice??"0"))){
              return 'Giá cước chỉ được nhập từ ${e.minPrice?.formatNumber} đến ${e.maxPrice?.formatNumber}';
            }
            return null;
          },
          onChanged: (v) {
            final string = v.formatNumber;
            e.edtController?.value = TextEditingValue(
              text: string,
              selection: TextSelection.collapsed(offset: string.length),
            );
          },
        ),
      ),).toList(),
    );
  }


  Future updateFee() async{
    final bool isValid = formKey.currentState?.validate() == true;
    print(">>>>>> $isValid");
    if (isValid) {
      List<PriceSettingDTO> dto = listData.map((e) => PriceSettingDTO(
          rideHailingFeeId: int.tryParse(e.id ?? ""),
          fee: int.tryParse(e.edtController?.text.removeComma ?? "0")
      )).toList();

      var setting = jsonEncode(dto.map((e) => e.toJson()).toList());

      final res = await profileRepo.updatePriceRideHailing(
          appData.tokenLogin, setting);
      if(res.status == true){
        AppNavigator.pop(true);
      }else{
        EasyLoading.showError(res.mess ?? "");
      }
    }else{
        autoValidateMode = AutovalidateMode.onUserInteraction;
        notifyListeners();
    }


  }

}