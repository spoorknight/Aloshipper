import '../../../shared/my_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../configs/config.dart';

class ModalRate extends StatelessWidget {
  const ModalRate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BoxConst.s8,
        Text('Đánh giá về bạn', style: AppFont.t.s(18).red),
        const Divider(color: Palette.grey),
        Expanded(
          child: ListView.separated(
            padding: AppTheme.mainPadding,
            itemCount: 10,
            separatorBuilder: (_, i) => const MySeparator(),
            itemBuilder: (_, i) => Row(
              children: [
                Container(
                  width: 90.w,
                  height: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    border: Border.all(color: Palette.grey),
                  ),
                  child: const Icon(Icons.person, size: 30),
                ),
                BoxConst.s8,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingBar.builder(
                        itemSize: 24,
                        initialRating: 4,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {},
                      ),
                      BoxConst.s8,
                       Text('Rất hài lòng về anh shiper',
                          style: AppFont.t),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Chú ý: ',
                  style: AppFont.t.red,
                ),
                 TextSpan(
                  text: 'Đánh giá này sẽ ảnh hưởng đến việc nhận đơn của bạn',
                  style: AppFont.t,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
