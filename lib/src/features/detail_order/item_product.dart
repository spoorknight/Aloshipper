import 'package:app_shipper/src/configs/config.dart';
import 'package:app_shipper/src/shared/my_separator.dart';
import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../models/shared_models/product.dart';

// class ItemProduct extends StatelessWidget {
//   const ItemProduct({Key? key, required this.product, required this.index})
//       : super(key: key);
//   final Product product;
//   final int index;
//
//   @override
//   Widget build(BuildContext context) {
//     final money =
//         (product.price ?? 0) * (int.tryParse(product.quantity ?? '') ?? 0);
//
//     return Column(
//       children: [
//         const MySeparator(),
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ClipOval(
//               child: Container(
//                 width: 50.h,
//                 height: 50.h,
//                 color: Palette.red,
//                 child: Center(
//                   child: Text(
//                     '${index + 1}',
//                     style: AppFont.t.s(28).w700.white,
//                   ),
//                 ),
//               ),
//             ),
//             Box.s8,
//             Expanded(
//               child: SizedBox(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(product.title ?? ''),
//                     Box.s4,
//                     Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '${product.price ?? 0}'.toVnd,
//                           style: AppFont.t,
//                         ),
//                         Text(
//                           '${product.quantity ?? 0}',
//                           style: AppFont.t,
//                         ),
//                         Text(
//                           '$money'.toVnd,
//                           style: AppFont.t.red,
//                         ),
//                       ],
//                     ),
//                     if (product.options?.isNotEmpty ?? false) ...[
//                       const Divider(),
//                       Wrap(
//                         children: [
//                           ...product.options!.map(
//                             (e) => Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('${e.name ?? ''}:', style: AppFont.t),
//                                 Text('${e.price ?? 0}'.toVnd,
//                                     style: AppFont.t.red),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                     if (product.orderGhichu?.isNotEmpty == true) ...[
//                       const Divider(color: Palette.grey),
//                       Text('Ghi chú: ${product.orderGhichu}', style: AppFont.t),
//                     ]
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
class ItemProduct extends StatelessWidget {
  const ItemProduct(
      {Key? key,
      required this.product,
      required this.index,
      this.isLastPage = false})
      : super(key: key);
  final Product product;
  final int index;
  final bool isLastPage;

  @override
  Widget build(BuildContext context) {
    final money =
        (product.price ?? 0) * (int.tryParse(product.quantity ?? '') ?? 0);
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                '${index + 1}',
                style: AppFont.t.s(16).w400.black,
              ),
            ),
            BoxConst.s16,
            Expanded(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title ?? '',
                      style: AppFont.t.s(13).w700.black,
                    ),
                    BoxConst.s4,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${product.price ?? 0}'.toVnd,
                          style: AppFont.t.s(16).w400.black,
                        ),
                        Text(
                          '${product.quantity ?? 0}',
                          style: AppFont.t.s(16).w400.black,
                        ),
                        Text(
                          '$money'.toVnd,
                          style: AppFont.t.s(16).w400.black,
                        ),
                      ],
                    ),
                    if (product.options?.isNotEmpty ?? false) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              product.getOptionsName,
                              style: AppFont.t.s(13).w400.black,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '${product.getTotalPriceOptions}'.toVnd,
                            style: AppFont.t.s(16).w400.black,
                          ),
                        ],
                      ),
                    ],
                    // if (product.orderGhichu?.isNotEmpty == true) ...[
                    //   const Divider(color: Palette.grey),
                    //   Text('Ghi chú: ${product.orderGhichu}', style: AppFont.t),
                    // ]
                  ],
                ),
              ),
            ),
          ],
        ),
        const MySeparator(),
      ],
    );
  }
}
