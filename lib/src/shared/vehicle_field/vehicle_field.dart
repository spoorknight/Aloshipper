// ignore_for_file: use_build_context_synchronously

import 'package:app_shipper/src/data/repositories/profile_repository.dart';
import 'package:app_shipper/src/models/vehicle_model/vehicle_model_by_brand.dart';
import 'package:app_shipper/src/models/vehicle_model/vehicle_selected.dart';
import 'package:app_shipper/src/models/vehicle_model/vehilce_brand_model.dart';
import 'package:app_shipper/src/shared/button.dart';
import 'package:app_shipper/src/shared/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../configs/config.dart';
import '../text_form_field.dart';

class VehicleField extends StatefulWidget {
  final String? title;
  final String? hintText;
  final VehicleSelected? vehicleSelected;
  final VoidCallback? onComplete;
  final ProfileRepository profileRepository;
   const VehicleField({super.key, this.title, this.hintText, this.vehicleSelected, this.onComplete, required this.profileRepository});

  @override
  State<VehicleField> createState() => _VehicleFieldState();
}

class _VehicleFieldState extends State<VehicleField> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController vehicleYear = TextEditingController();
  final TextEditingController finalVehicleCtl = TextEditingController();
  final TextEditingController searchCtl = TextEditingController();
  final FocusNode focusNode = FocusNode();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  List<VehicleBrand> listVehicleBrands = [];
  List<VehicleModel> listVehicleModel  = [];

  VehicleBrand? vehicleBrand;
  VehicleModel? vehicleModel;


  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    vehicleBrand = widget.vehicleSelected?.vehicleBrand;
    vehicleModel = widget.vehicleSelected?.vehicleModel;
    vehicleYear.text = widget.vehicleSelected?.vehicleYear ?? "";
    finalVehicleCtl.text = widget.vehicleSelected?.fullVehicle ?? "";
    await getVehicleBrand();
    await getVehicleModel(vehicleBrand?.id ?? "");

    setState(() {});
  }





  Future<void> getVehicleBrand() async {
    EasyLoading.show();
    await widget.profileRepository
        .getVehicleBrands()
        .then((res) {
      if (res.status == true) {
        listVehicleBrands = [
          ...res.data ?? [VehicleBrand(name: 'Không có dữ liệu')]
        ];
      }
      EasyLoading.dismiss();
      setState(() {});
    });
  }

  Future<void> getVehicleModel(String brand_id) async {
    EasyLoading.show();
    await widget.profileRepository
        .getVehicleModelByBrand(brand_id)
        .then((res) {
      if (res.status == true) {
        listVehicleModel = [
          ...res.data ?? [VehicleModel(name: 'Không có dữ liệu')]
        ];
      }
      EasyLoading.dismiss();
      setState(() {});
    });
  }

  Widget _buildDialog(BuildContext dialogContext) {
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeaderDialog(dialogContext),
              const Divider(thickness: 1, height: 1),
              _buildBodyDialog(setState, dialogContext),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBodyDialog(StateSetter setState, BuildContext dialogContext) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            BoxConst.s24,
            _buildVehicleBrandDropdown(setState),
            BoxConst.s24,
            _buildVehicleModelDropdown(setState),
            BoxConst.s24,
            _buildDetailVehicleYearField(),
            BoxConst.s24,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildButtonClose(setState,dialogContext),
                BoxConst.s4,
                _buildButtonConfirm(dialogContext, setState),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleBrandDropdown(StateSetter setState) {
    return DropDownCustom<VehicleBrand?>(
      canSearch: true,
      searchController: searchCtl,
      searchMatchFn: (item, searchValue) {
        return (item.value.name
            .toLowerCase()
            .contains(searchValue.toLowerCase()));
      },
      autovalidateMode: autoValidateMode,
      title: 'Hãng xe',
      hintText: 'Hãng xe',
      selectedItemBuilder: (p0) => [
        ...listVehicleBrands.map(
              (e) => Text(
            e.name ?? '',
            style: AppFont.t,
          ),
        )
      ],
      listDynamic: [
        ...listVehicleBrands.map(
              (e) => DropdownMenuItem<VehicleBrand?>(
            value: e,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                e.name ?? '',
                style: AppFont.t,
              ),
            ),
          ),
        )
      ],
      validator: (value) {
        if (value == null) {
          return 'Hãng xe không được để trống';
        }
        return null;
      },
      value: vehicleBrand,
      onChange: (value) {
        setState(() {
          vehicleBrand = value;
          vehicleModel = null;
          vehicleYear.text = '';
        });
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await getVehicleModel(vehicleBrand?.id ?? '');
          setState(() {});
        });
      },
    );
  }

  Widget _buildVehicleModelDropdown(StateSetter setState) {
    return DropDownCustom<VehicleModel?>(
      canSearch: true,
      searchController: searchCtl,
      searchMatchFn: (item, searchValue) {
        return (item.value.name
            .toLowerCase()
            .contains(searchValue.toLowerCase()));
      },
      autovalidateMode: autoValidateMode,
      validator: (value) {
        if (value == null) {
          return 'Dòng xe không được để trống';
        }
        return null;
      },
      title: 'Dòng xe',
      hintText: 'Dòng xe',
      selectedItemBuilder: (p0) => [
        ...listVehicleModel.map(
              (e) => Text(
            e.name ?? '',
            style: AppFont.t,
          ),
        )
      ],
      listDynamic: [
        ...listVehicleModel.map(
              (e) => DropdownMenuItem<VehicleModel?>(
            value: e,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                e.name ?? '',
                style: AppFont.t,
              ),
            ),
          ),
        )
      ],
      value: vehicleModel,
      onChange: (value) {
        setState(() {
          vehicleModel = value;
          vehicleYear.text = '';
        });
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          setState(() {});
        });
      },
    );
  }

  CustomTextFormField _buildDetailVehicleYearField() {
    return CustomTextFormField(
      title: 'Năm sản xuất',
      hintText: 'Năm sản xuất',
      controller: vehicleYear,
      focusNode: focusNode,
      autovalidateMode: autoValidateMode,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Năm sản xuất không được để trống';
        }
        return null;
      },
    );
  }

  Widget _buildButtonConfirm(
      BuildContext dialogContext, StateSetter setState) {
    return MyButton.rounded(
      height: 45,
      width: 100.w,
      borderRadius: 5,
      title: 'Xác nhận',
      action: () {
        final bool isValid = formKey.currentState?.validate() == true;
        if (isValid) {
          setData();
          Navigator.pop(dialogContext);
        } else {
          setState(() {
            autoValidateMode = AutovalidateMode.onUserInteraction;
          });
        }
      },
    );
  }

  Widget _buildButtonClose(StateSetter setState,BuildContext dialogContext) {
    return MyTextButton(
      height: 45,
      width: 70.w,
      alignment: Alignment.centerLeft,
      text: 'Đóng',
      action: () {
        clearData();
        Navigator.pop(dialogContext);
      },
    );
  }

  Padding _buildHeaderDialog(BuildContext dialogContext) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Nhập địa chỉ',
            style: AppFont.t.s(16).w700,
          ),
          IconButton(
            onPressed: () {
              clearData();
              Navigator.pop(dialogContext);
            },
            icon: const Icon(
              Icons.close,
              color: Palette.icon,
            ),
          )
        ],
      ),
    );
  }


  void clearData(){
    vehicleBrand = null;
    vehicleModel = null;
    vehicleYear.text = '';
    finalVehicleCtl.text = '';
  }

  void setData(){
    String fullVehicle = '';
    if(vehicleBrand != null && vehicleModel != null && vehicleYear.text.isNotEmpty){
      fullVehicle = '${vehicleBrand!.name} | ${vehicleModel!.name} | ${vehicleYear.text}';
    }else{
      fullVehicle = '';
    }
    finalVehicleCtl.text = fullVehicle;
    widget.vehicleSelected
    ?..vehicleBrand = vehicleBrand
    ..vehicleModel = vehicleModel
    .. vehicleYear = vehicleYear.text
    ..fullVehicle = fullVehicle;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return CustomTextFormFieldVerify(
      readOnly: true,
      title: widget.title,
      hintText: widget.hintText,
      controller: finalVehicleCtl,
      onTap: () async {
        await getVehicleBrand();
        await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (dialogContext) => _buildDialog(dialogContext),
        );
        widget.onComplete?.call();
      },
    );
  }

}
