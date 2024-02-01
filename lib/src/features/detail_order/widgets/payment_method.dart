part of '../detail_driver_order.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key, required this.order});

  final Item order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.boxDecoration
          .copyWith(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phương thức thanh toán',
            style: AppFont.t.s(14).w400.black,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              order.getIconPaymentType!,
              BoxConst.s4,
              Text(
                order.getStrPaymentMethod,
                style: AppFont.t.s(13).w400.nuatral90,
              )
            ],
          ),
        ],
      ),
    );
  }
}
