part of '../detail_driver_order.dart';

class ItemDriver extends StatelessWidget {
  final ShipperModel shipper;
  final bool isCallDriver;
  final double? fee;
  final double? distance;
  final bool? isCallShipper;
  final DetailOrderModel? detailOrder;

  const ItemDriver({
    Key? key,
    this.isCallDriver = true,
    this.fee,
    this.distance,
    this.isCallShipper,
    this.detailOrder,
    required this.shipper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.shapeDecoration,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: [
          renderAvatar(),
          BoxConst.s8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        shipper.fullName ?? '',
                        style: AppFont.t.s(16).w500.nuatral90,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // if (isCallDriver == true)
                    //   InkWell(
                    //     onTap: () async {
                    //       await Utils().launchPhone(shipper.phoneNumber ?? '');
                    //     },
                    //     child: const CircleAvatar(
                    //       radius: 20,
                    //       backgroundColor: Palette.success,
                    //       child: Icon(
                    //         Icons.phone,
                    //         color: Palette.white,
                    //         size: 20,
                    //       ),
                    //     ),
                    //   )
                  ],
                ),
                BoxConst.s4,
                Text(
                  shipper.biensoxe ?? '',
                  style: AppFont.t.s(13).w400.nuatral90,
                ),
                BoxConst.s4,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'Phí áp dụng',
                            style: AppFont.t.s(14).w400.black,
                          ),
                               InkWell(
                              onTap: () =>detailOrder == null ? null :
                              showDialog(context: context, builder: (context)
                              => Padding(
                                  padding: AppTheme.mainPadding,
                                  child: DialogServiceFee(order: detailOrder!)),),
                              child: Assets.svgs.icInfo.svg())
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${detailOrder?.item?.phiship}'.toVnd,
                        textAlign: TextAlign.right,
                        style: AppFont.t.s(14).w400.black,
                      ),
                    ),
                  ],
                ),
                BoxConst.s4,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                          text: 'Tổng tiền ',
                          style: AppFont.t.s(13).w400.nuatral90,
                          children: [
                            TextSpan(
                              text: '($distance km)',
                              style: AppFont.t.s(13).w400.nuatral50,
                            )
                          ]),
                    ),
                    Text(
                      fee.toString().toVnd,
                      style: AppFont.t
                          .s(16)
                          .w700
                          .black
                          .copyWith(color: Palette.primarySecond),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget renderAvatar() {
    return Column(
      children: [
        ClipOval(
          child: Container(
            width: 64.w,
            height: 64.w,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: CachedNetworkImageCustom(
              url: shipper.avatar,
            ),
          ),
        ),
        BoxConst.s4,
        Row(
          children: [
            const Icon(Icons.star, color: Palette.yellow, size: 16),
            Text(
              shipper.rating?.rating ?? '0',
              style: AppFont.t.s(10).w400.black,
            ),
          ],
        ),
      ],
    );
  }
}
