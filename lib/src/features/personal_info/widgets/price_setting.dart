import 'package:app_shipper/src/features/profile/profile_view_model.dart';
import 'package:app_shipper/src/utils/extensions/context_extension.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../configs/config.dart';
import '../../../shared/button.dart';
import '../../../shared/text_form_field.dart';

enum PriceType { giaoHang, goiXe, phiKmDau }

class PriceSetting extends StatelessWidget {
  final PriceType type;

  const PriceSetting({
    Key? key,
    required this.type,
  }) : super(key: key);

  String get title {
    switch (type) {
      case PriceType.phiKmDau:
      case PriceType.giaoHang:
        return 'giao hàng';
      case PriceType.goiXe:
        return 'gọi xe';
      default:
        return '';
    }
  }

  void _onChange(String text, ProfileViewModel viewModel) {
    final string = text.formatNumber;
    switch (type) {
      case PriceType.phiKmDau:
        viewModel.phiKmDauTien.value = TextEditingValue(
          text: string,
          selection: TextSelection.collapsed(offset: string.length),
        );
        break;
      case PriceType.giaoHang:
        viewModel.phiGiaoHangEC.value = TextEditingValue(
          text: string,
          selection: TextSelection.collapsed(offset: string.length),
        );
        break;
      case PriceType.goiXe:
        viewModel.phiGoiXeEC.value = TextEditingValue(
          text: string,
          selection: TextSelection.collapsed(offset: string.length),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileViewModel>();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BoxConst.s8,
            Text('Cài đặt phí $title', style: AppFont.t.s(18).red),
            const Divider(color: Palette.grey),
            BoxConst.s16,
            Padding(
              padding: AppTheme.mainPadding,
              child: CustomTextFormField(
                title: 'Nhập giá cước mong muốn',
                hintText: 'Nhập giá cước mong muốn',
                controller: type == PriceType.phiKmDau
                    ? viewModel.phiKmDauTien
                    : type == PriceType.giaoHang
                        ? viewModel.phiGiaoHangEC
                        : viewModel.phiGoiXeEC,
                inputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                onChanged: (v) => _onChange(v, viewModel),
              ),
            ),
            BoxConst.s16,
            _note(type),
            BoxConst.s16,
            _buttonSubmit(context, viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buttonSubmit(BuildContext context, ProfileViewModel viewModel) {
    return MyButton(
        title: 'Xác nhận',
        borderRadius: 4,
        action: () {
          context.hideKeyboard;
          switch (type) {
            case PriceType.phiKmDau:
              viewModel.updatePhiKmDauTien();
              break;
            case PriceType.giaoHang:
              // viewModel.updatePhiGiaoHang();
              break;
            case PriceType.goiXe:
              viewModel.updatePhiGoiXe();
              break;
            default:
              break;
          }
        });
  }

  Widget _note(PriceType type) {
    late TextSpan content;
    switch (type) {
      case PriceType.phiKmDau:
        content = TextSpan(
          text: 'Phí km đầu sẽ ảnh hưởng tới việc nhận đơn từ khách hàng.',
          style: AppFont.t,
        );
        break;
      case PriceType.giaoHang:
        content = TextSpan(
          text: 'Phí giao hàng sẽ ảnh hưởng tới việc nhận đơn từ khách hàng.',
          style: AppFont.t,
        );
        break;
      case PriceType.goiXe:
        content = TextSpan(
          text: 'Phí gọi xe sẽ ảnh hưởng tới việc nhận đơn từ khách hàng.',
          style: AppFont.t,
        );
        break;
      default:
        break;
    }
    return Padding(
      padding: AppTheme.mainPadding,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Lưu ý: ',
              style: AppFont.t.red,
            ),
            content,
          ],
        ),
      ),
    );
  }
}
