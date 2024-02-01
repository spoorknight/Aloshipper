import 'discount_product_view_model.dart';
import '../../shared/cache_image_network.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../configs/config.dart';
import '../../models/list_discount_product_model/discount_product_model.dart';
import '../../shared/app_bar.dart';
import '../../shared/empty.dart';
import '../../shared/loading.dart';
import '../../shared/my_scaffold.dart';
import '../../shared/my_separator.dart';
import '../../utils/extensions/extensions.dart';

class DiscountProductScreen extends StatelessWidget {
  const DiscountProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DiscountProductViewModel>();
    return MyScaffold(
      appBar: const MyAppBar(title: 'Danh sách sản phẩm đang chiết khấu'),
      body: viewModel.isLoading
          ? const Loading()
          : SmartRefresher(
              controller: viewModel.refreshCtl,
              onLoading: () => viewModel.loadMore(),
              enablePullUp: viewModel.isLastPage ? false : true,
              onRefresh: () => viewModel.onRefresh(),
              child: viewModel.discountProducts.isEmpty
                  ? const Empty()
                  : ListView.separated(
                      controller: viewModel.scrollCrl,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: viewModel.discountProducts.length,
                      separatorBuilder: (_, i) => const MySeparator(),
                      itemBuilder: (_, i) => _ItemDiscountProduct(
                        product: viewModel.discountProducts[i],
                        share: () => viewModel.shareShortLink(
                            viewModel.discountProducts[i].urlAffLink),
                      ),
                    ),
            ),
    );
  }
}

class _ItemDiscountProduct extends StatelessWidget {
  final DiscountProductModel product;
  final VoidCallback share;

  const _ItemDiscountProduct({
    Key? key,
    required this.product,
    required this.share,
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
                    'Mã sản phẩm: #${product.sku}',
                    style: AppFont.t,
                  ),
                  Text(
                    'Thời hạn đến ${product.hethan}',
                    style: AppFont.t.s(12).hint,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                '${product.chieckhau}'.toVnd,
                style: AppFont.t.green,
              ),
            ),
            IconButton(
              onPressed: share,
              icon: const Icon(Icons.share),
            ),
          ],
        ),
        const Divider(),
        Row(
          children: [
            CachedNetworkImageCustom(
              url: product.image ?? '',
              height: 70.h,
              width: 70.h,
              boxFit: BoxFit.cover,
            ),
            BoxConst.s8,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title ?? '', style: AppFont.t),
                RatingBar.builder(
                  ignoreGestures: true,
                  itemSize: 16,
                  initialRating:
                      double.tryParse(product.rating.toString()) ?? 0,
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
                        text: '${product.chieckhau}'.toVnd,
                        style: AppFont.t.s(12).green,
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: 'Link giới thiệu: ',
                    style: AppFont.t.s(12).hint,
                    children: [
                      TextSpan(
                        text: product.urlAffLink,
                        style: AppFont.t.s(12).red,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchUrlString(
                                product.urlAffLink ?? '',
                                mode: LaunchMode.externalApplication,
                              ),
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
