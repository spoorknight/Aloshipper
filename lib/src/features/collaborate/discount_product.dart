import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../configs/config.dart';
import '../../shared/app_bar.dart';
import '../../shared/my_scaffold.dart';
import '../../shared/my_separator.dart';

class DiscountProduct extends StatelessWidget {
  const DiscountProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: const MyAppBar(title: 'Danh sách sản phẩm đang chiết khấu'),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: 10,
        separatorBuilder: (_, i) => const MySeparator(),
        itemBuilder: (_, i) => const _ItemDiscountProduct(),
      ),
    );
  }
}

class _ItemDiscountProduct extends StatelessWidget {
  const _ItemDiscountProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Mã sản phẩm: #SP123456',
                    style: AppFont.t,
                  ),
                  Text(
                    'Thời hạn đến 30/05/2022',
                    style: AppFont.t.s(12).hint,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                '+ 5,000 đ',
                style: AppFont.t.green,
              ),
            ),
            CupertinoSwitch(value: true, onChanged: (v) {}),
          ],
        ),
        const Divider(),
        Row(
          children: [
            Assets.images.milkTea.image(
              width: 0.6.sw,
              height: 0.6.sw,
            ),
            BoxConst.s8,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Trà sữa trân châu', style: AppFont.t),
                RatingBar.builder(
                  itemSize: 16,
                  initialRating: 4,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {},
                ),
                Text.rich(
                  TextSpan(
                    text: 'Hoa hồng: ',
                    style: AppFont.t.s(12).hint,
                    children: [
                      TextSpan(
                        text: '5,000 đ',
                        style: AppFont.t.s(12).green,
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: 'Link: ',
                    style: AppFont.t.s(12).hint,
                    children: [
                      TextSpan(
                        text: 'https://www.google.com/abcxyz/asdf',
                        style: AppFont.t.s(12).red,
                      ),
                    ],
                  ),
                ),
              ],
            ))
          ],
        )
      ],
    );
  }
}
