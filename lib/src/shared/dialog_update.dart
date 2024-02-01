import 'package:app_shipper/src/configs/config.dart';
import 'package:flutter/material.dart';

class DialogUpdate extends StatelessWidget {
  const DialogUpdate({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24.w),
        width: MediaQuery.of(context).size.width / 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.svgs.amicoUpdate.svg(width: 160, height: 160),
            BoxConst.s8,
            Text(
              'Cập nhật phiên bản mới',
              style: AppFont.t.s(20).w500.black,
            ),
            BoxConst.s8,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Icon(
                    Icons.circle,
                    size: 3,
                    color: Palette.black,
                  ),
                ),
                BoxConst.s8,
                Text(
                  'Nâng cấp trãi nghiệm người dùng.',
                  style: AppFont.t.s(14).w500.black,
                ),
              ],
            ),
            BoxConst.s8,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Icon(
                    Icons.circle,
                    size: 3,
                    color: Palette.black,
                  ),
                ),
                BoxConst.s8,
                Expanded(
                  child: Text(
                    'Cập nhật những tính năng mới, tối ưu tốc độ xử lý hệ thống',
                    style: AppFont.t.s(14).w500.black,
                  ),
                ),
              ],
            ),
            BoxConst.s8,
            InkWell(
              onTap: onPressed,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                decoration: AppTheme.boxDecoration.copyWith(
                  color: Palette.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Cập nhật',
                  style: AppFont.t.s(13).w700.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
