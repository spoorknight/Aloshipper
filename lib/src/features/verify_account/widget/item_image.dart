import 'dart:io';

import 'package:app_shipper/src/configs/config.dart';
import 'package:app_shipper/src/features/register/register_view_model.dart';
import 'package:app_shipper/src/shared/cache_image_network.dart';
import 'package:flutter/material.dart';

class ItemImage extends StatefulWidget {
  ImageModel model;
  Function pickImage;
  Function onDelete;
   ItemImage({super.key,required this.model,required this.pickImage,required this.onDelete});

  @override
  State<ItemImage> createState() => _ItemImageState();
}

class _ItemImageState extends State<ItemImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: (1.sw - 64.w) / 4.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => widget.pickImage(),
                child: Container(
                  height: (1.sw - 64.w) / 4.5,
                  // padding: EdgeInsets.all(5),
                  decoration: AppTheme.boxDecoration.copyWith(
                      borderRadius:   BorderRadius.circular(10)),
                  child: Center(
                    child: widget.model.image != null
                        ? ClipRRect(
                      borderRadius:
                      BorderRadius.circular(10),
                      child: Image.file(
                          File(widget.model.image!.path),
                          fit: BoxFit.cover),
                    )
                        : widget.model.networkImage != null
                        ? CachedNetworkImageCustom(
                      url: widget.model.networkImage,
                      borderRadius: 10,
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.svgs.icCamera.svg(),
                            BoxConst.s4,
                            Text("Tải ảnh lên",style: AppFont.t.s(12).linkBlue),
                          ],
                        ),
                  ),
                ),
              ),
              BoxConst.s4,
              Text(
                widget.model.title,
                style: AppFont.t.s(12).nuatral50,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        if (widget.model.image != null)
          Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              onTap: () => widget.onDelete(),
              child: Container(
                decoration: const BoxDecoration(
                    color: Palette.black),
                child: const Icon(Icons.close,
                    color: Palette.white, size: 12),
              ),
            ),
          )
      ],
    );
  }
}
