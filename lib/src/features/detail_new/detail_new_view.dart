import 'package:app_shipper/src/models/list_notification_model/list_new_model.dart';
import 'package:app_shipper/src/shared/cache_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../configs/config.dart';

class DetailNewScreen extends StatelessWidget {
  NotificationNewModel model;
  DetailNewScreen({super.key,required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Palette.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Palette.white,
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoxConst.s12,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoxConst.s4,
                  Text(
                    model.updatedAt ?? "",
                    style: AppFont.t.s(10).w400.nuatral50,
                  ),
                  BoxConst.s4,
                  Text(
                    model.title ?? "",
                    style: AppFont.t.s(13).w700.nuatral90,
                  ),
                  BoxConst.s4,
                  Html(data: model.fullContent)
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}
