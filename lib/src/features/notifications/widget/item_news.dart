import 'package:app_shipper/src/configs/config.dart';
import 'package:app_shipper/src/models/list_notification_model/list_new_model.dart';
import 'package:app_shipper/src/shared/cache_image_network.dart';
import 'package:flutter/material.dart';

class ItemNews extends StatelessWidget {
  NotificationNewModel model;
    ItemNews({super.key,required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: AppTheme.boxDecoration.copyWith(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )
            ),
            child: CachedNetworkImageCustom(
              url: model.image,
              width: MediaQuery.of(context).size.width,
            ),
          ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               BoxConst.s4,
               Row(
                 children: [
                   status(model.isRead ?? false),
                   BoxConst.s4,
                   Text(
                     model.updatedAt ?? "",
                     style: AppFont.t.s(10).w400.nuatral50,
                   ),
                 ],
               ),
               BoxConst.s4,
               Text(
                 model.title ?? "",
                 style: AppFont.t.s(13).w700.nuatral90,
               ),
               BoxConst.s4,
               Text(
                 model.content ?? "",
                 style: AppFont.t.s(10).w400.nuatral50,
               ),
             ],
           ),
         )


        ],
      ),
    );
  }


  Widget status(bool isRead){

    if(isRead == true){
      return const SizedBox();
    }
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        color: Palette.green,
        borderRadius: BorderRadius.circular(50)
      ),
    );
  }
}
