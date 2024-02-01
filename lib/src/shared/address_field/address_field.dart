// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../configs/config.dart';

import '../../data/repositories/profile_repository.dart';
import '../../di/injection/injection.dart';
import '../../models/list_address_model.dart/address_model.dart';
import '../../utils/helpers/logger.dart';
import '../button.dart';
import '../dropdown.dart';
import '../text_form_field.dart';

class AddressFiled extends StatefulWidget {
  final String? title;
  final String? hintText;
  final AddressSelected? addressSelected;
  final VoidCallback? onComplete;
  final ProfileRepository profileRepository;
  const AddressFiled({
    Key? key,
    this.title,
    this.hintText,
    this.addressSelected,
    this.onComplete,
    required this.profileRepository,
  }) : super(key: key);

  @override
  State<AddressFiled> createState() => _AddressFiledState();
}

class _AddressFiledState extends State<AddressFiled> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController finalAddrCtl = TextEditingController();
  final TextEditingController detailAddrCtl = TextEditingController();
  final TextEditingController searchCtl = TextEditingController();
  final FocusNode focusNode = FocusNode();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  List<AddressModel?> listProvince = [];
  List<AddressModel?> listDistrict = [];
  List<AddressModel?> listCommune = [];

  AddressModel? provinceSelected;
  AddressModel? districtSelected;
  AddressModel? communeSelected;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    communeSelected = widget.addressSelected!.commune;
    districtSelected = widget.addressSelected!.district;
    provinceSelected = widget.addressSelected!.province;
    detailAddrCtl.text = widget.addressSelected!.detailAddr ?? '';
    finalAddrCtl.text = widget.addressSelected!.fullAddr ?? '';
    await getQuanHuyenList(districtSelected?.countryId ?? '');
    await getPhuongXaList(communeSelected?.stateId ?? '');
    Logger.d("Province", provinceSelected?.toJson());
    Logger.d("District", districtSelected?.toJson());
    Logger.d("Commune", communeSelected?.toJson());
    setState(() {});
  }

  void trimSpace() {
    if (!focusNode.hasFocus) {
      detailAddrCtl.text = detailAddrCtl.text.trim();
    }
  }

  void setData(value) {
    String? fullAddress;
    if (detailAddrCtl.text.isNotEmpty &&
        communeSelected != null &&
        districtSelected != null &&
        provinceSelected != null) {
      fullAddress =
          '${detailAddrCtl.text.trim()}, ${communeSelected!.name}, ${districtSelected!.name}, ${provinceSelected!.name}';
    } else {
      fullAddress = '';
    }
    finalAddrCtl.text = fullAddress;
    widget.addressSelected
      ?..province = provinceSelected
      ..district = districtSelected
      ..commune = communeSelected
      ..fullAddr = fullAddress
      ..detailAddr = detailAddrCtl.text;
    setState(() {});
  }

  Future<void> getTinhTPList() async {
    EasyLoading.show();
    setState(() {});
    await widget.profileRepository
        .getTinhTPList(
      appData.tokenLogin,
      appData.firebaseToken,
    )
        .then((res) {
      if (res.status == true) {
        listProvince = [
          ...res.item ?? [const AddressModel(name: 'Không có dữ liệu')]
        ];
      }
      EasyLoading.dismiss();
      setState(() {});
    });
  }

  Future<void> getQuanHuyenList(String tinh_id) async {
    EasyLoading.show();
    await widget.profileRepository
        .getQuanHuyenList(
      appData.tokenLogin,
      appData.firebaseToken,
      tinh_id,
    )
        .then((res) {
      if (res.status == true) {
        listDistrict = [
          ...res.item ?? [const AddressModel(name: 'Không có dữ liệu')]
        ];
      }
      EasyLoading.dismiss();
      setState(() {});
    });
  }

  Future<void> getPhuongXaList(String quan_id) async {
    EasyLoading.show();
    await widget.profileRepository
        .getPhuongXaList(
      appData.tokenLogin,
      appData.firebaseToken,
      quan_id,
    )
        .then((res) {
      if (res.status == true) {
        listCommune = [
          ...res.item ?? [const AddressModel(name: 'Không có dữ liệu')]
        ];
      }
      EasyLoading.dismiss();
      setState(() {});
    });
  }

  void clearData() {
    if (detailAddrCtl.text.isEmpty ||
        provinceSelected == null ||
        districtSelected == null ||
        communeSelected == null ||
        finalAddrCtl.text.isEmpty) {
      detailAddrCtl.text = '';
      provinceSelected = null;
      districtSelected = null;
      communeSelected = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final viewModel = context.watch<AddressFieldViewModel>();
    return CustomTextFormField(
      readOnly: true,
      title: widget.title,
      hintText: widget.hintText,
      controller: finalAddrCtl,
      onTap: () async {
        await getTinhTPList();
        await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (dialogContext) => _buildDialog(dialogContext),
        );
        widget.onComplete?.call();
      },
    );
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
            _buildProvinceDropdown(setState),
            BoxConst.s24,
            _buildDistrictDropdown(setState),
            BoxConst.s24,
            _buildCommuneDropdown(setState),
            BoxConst.s24,
            _buildDetailAddrField(),
            BoxConst.s24,
            Row(
              children: [
                _buildButtonReset(setState),
                _buildButtonConfirm(dialogContext, setState),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildButtonConfirm(
      BuildContext dialogContext, StateSetter setState) {
    return Expanded(
      child: MyButton.rounded(
        title: 'Xác nhận',
        action: () {
          final bool isValid = formKey.currentState?.validate() == true;
          if (isValid) {
            setData(isValid);
            Navigator.pop(dialogContext);
          } else {
            setState(() {
              autoValidateMode = AutovalidateMode.onUserInteraction;
            });
          }
        },
      ),
    );
  }

  Expanded _buildButtonReset(StateSetter setState) {
    return Expanded(
      child: MyTextButton(
        alignment: Alignment.centerLeft,
        text: 'Nhập lại',
        action: () {
          setState(() {
            detailAddrCtl.text = '';
            provinceSelected = null;
            districtSelected = null;
            communeSelected = null;
            finalAddrCtl.clear();
          });
        },
      ),
    );
  }

  CustomTextFormField _buildDetailAddrField() {
    return CustomTextFormField(
      title: 'Địa chỉ chi tiết',
      hintText: 'Địa chỉ chi tiết',
      controller: detailAddrCtl,
      focusNode: focusNode,
      autovalidateMode: autoValidateMode,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Địa chỉ chi tiết không được để trống';
        }
        return null;
      },
    );
  }

  Widget _buildCommuneDropdown(StateSetter setState) {
    return DropDownCustom<AddressModel?>(
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
          return 'Xã/Phường không được để trống';
        }
        return null;
      },
      title: 'Xã/Phường',
      hintText: 'Xã/Phường',
      selectedItemBuilder: (p0) => [
        ...listCommune.map(
          (e) => Text(
            e?.name ?? '',
            style: AppFont.t,
          ),
        )
      ],
      listDynamic: [
        ...listCommune.map(
          (e) => DropdownMenuItem<AddressModel?>(
            value: e,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                e?.name ?? '',
                style: AppFont.t,
              ),
            ),
          ),
        )
      ],
      value: communeSelected,
      onChange: (value) {
        setState(() {
          communeSelected = value;
          detailAddrCtl.clear();
        });
      },
    );
  }

  Widget _buildDistrictDropdown(StateSetter setState) {
    return DropDownCustom<AddressModel?>(
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
          return 'Quận/Huyện không được để trống';
        }
        return null;
      },
      title: 'Quận/Huyện',
      hintText: 'Quận/Huyện',
      selectedItemBuilder: (p0) => [
        ...listDistrict.map(
          (e) => Text(
            e?.name ?? '',
            style: AppFont.t,
          ),
        )
      ],
      listDynamic: [
        ...listDistrict.map(
          (e) => DropdownMenuItem<AddressModel?>(
            value: e,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                e?.name ?? '',
                style: AppFont.t,
              ),
            ),
          ),
        )
      ],
      value: districtSelected,
      onChange: (value) {
        setState(() {
          districtSelected = value;
          communeSelected = null;
          detailAddrCtl.clear();
        });
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await getPhuongXaList(districtSelected?.id ?? '');
          setState(() {});
        });
      },
    );
  }

  Widget _buildProvinceDropdown(StateSetter setState) {
    return DropDownCustom<AddressModel?>(
      canSearch: true,
      searchController: searchCtl,
      searchMatchFn: (item, searchValue) {
        return (item.value.name
            .toLowerCase()
            .contains(searchValue.toLowerCase()));
      },
      autovalidateMode: autoValidateMode,
      title: 'Tỉnh/Thành phố',
      hintText: 'Tỉnh/Thành phố',
      selectedItemBuilder: (p0) => [
        ...listProvince.map(
          (e) => Text(
            e?.name ?? '',
            style: AppFont.t,
          ),
        )
      ],
      listDynamic: [
        ...listProvince.map(
          (e) => DropdownMenuItem<AddressModel?>(
            value: e,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                e?.name ?? '',
                style: AppFont.t,
              ),
            ),
          ),
        )
      ],
      validator: (value) {
        if (value == null) {
          return 'Tỉnh/Thành phố không được để trống';
        }
        return null;
      },
      value: provinceSelected,
      onChange: (value) {
        setState(() {
          provinceSelected = value;
          districtSelected = null;
          communeSelected = null;
          detailAddrCtl.clear();
        });
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await getQuanHuyenList(provinceSelected?.id ?? '');
          setState(() {});
        });
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
}
