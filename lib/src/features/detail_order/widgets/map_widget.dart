part of '../detail_driver_order.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    super.key,
    required this.addressFrom,
    required this.addressTo,
    this.handleNavigateFromAddress,
    this.handleNavigateToAddress,
    this.titleFrom = 'Điểm đi:',
    this.titleTo = 'Điểm đến:',
    this.isShowMap = true,
  });

  final String addressFrom;
  final String addressTo;
  final Function()? handleNavigateFromAddress;
  final Function()? handleNavigateToAddress;
  final String titleFrom;
  final String titleTo;
  final bool isShowMap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.boxDecoration
          .copyWith(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Assets.svgs.icShipFrom.svg(width: 30, height: 30),
              Assets.images.arrow
                  .image(width: 10.w, height: 26.w, fit: BoxFit.fitHeight),
              Assets.svgs.icShipTo.svg(width: 30, height: 30),
            ],
          ),
          BoxConst.s8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titleFrom,
                            style: AppFont.t.s(14).w600.black,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          BoxConst.s4,
                          Text(
                            addressFrom,
                            style: AppFont.t,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (isShowMap)
                      InkWell(
                        onTap: handleNavigateFromAddress,
                        child: Assets.svgs.direct.svg(width: 30, height: 30),
                      ),
                  ],
                ),
                BoxConst.s12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titleTo,
                            style: AppFont.t.s(14).w600.black,
                          ),
                          BoxConst.s4,
                          Text(
                            addressTo,
                            style: AppFont.t,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (isShowMap)
                      InkWell(
                        onTap: handleNavigateToAddress,
                        child: Assets.svgs.direct.svg(width: 30, height: 30),
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
}
