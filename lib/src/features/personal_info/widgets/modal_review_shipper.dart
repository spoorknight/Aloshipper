import 'package:app_shipper/src/features/profile/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../shared/cache_image_network.dart';
import '../../../shared/empty.dart';
import '../../../shared/loading.dart';
import '../../../shared/my_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../configs/config.dart';

class ModalReviewShipper extends StatelessWidget {
  const ModalReviewShipper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileViewModel>();
    return Column(
      children: [
        BoxConst.s8,
        Text('Đánh giá về bạn', style: AppFont.t.s(18).red),
        const Divider(color: Palette.grey),
        Expanded(
          child: viewModel.isLoading
              ? const Loading()
              : SmartRefresher(
                  controller: viewModel.refreshCtl,
                  onLoading: () => viewModel.loadMore(),
                  enablePullUp: viewModel.isLastPage ? false : true,
                  onRefresh: () => viewModel.onRefresh(),
                  child: viewModel.listReviewShipper.isEmpty
                      ? const Empty()
                      : ListView.separated(
                          controller: viewModel.scrollCrl,
                          padding: AppTheme.mainPadding,
                          itemCount: viewModel.listReviewShipper.length,
                          separatorBuilder: (_, i) => const MySeparator(),
                          itemBuilder: (_, i) {
                            final review = viewModel.listReviewShipper[i];
                            return Row(
                              children: [
                                ClipOval(
                                  child: Container(
                                    width: 70.h,
                                    height: 70.h,
                                    decoration: const BoxDecoration(shape: BoxShape.circle),
                                    child: CachedNetworkImageCustom(
                                      url: review.memberObj?.avatar,
                                    ),
                                  ),
                                ),
                                BoxConst.s8,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RatingBar.builder(
                                        ignoreGestures: true,
                                        itemSize: 24,
                                        initialRating: double.tryParse(review.rating ?? '') ?? 0.0,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                                        onRatingUpdate: (rating) {},
                                      ),
                                      BoxConst.s8,
                                      Text(review.review ?? '', style: AppFont.t),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Text.rich(
            textAlign: TextAlign.center,
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
