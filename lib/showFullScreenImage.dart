import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_app/models/image.dart';
import 'package:gallery_app/utils/utility.dart';
import 'package:photo_view/photo_view.dart';

class showFullScreenImage extends StatelessWidget {
  final Photo photo;

  const showFullScreenImage({Key key, this.photo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mediaquery=MediaQuery.of(context);

    final appbar=AppBar(
      title: Text('My Gallery',style: Theme.of(context).textTheme.title,),
      centerTitle: true,
    );
    final height=mediaquery.size.height-appbar.preferredSize.height-mediaquery.padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: (height)*0.1,horizontal: 15),
        child: Container(
          height: (height)*0.9,
          width: mediaquery.size.width,
          color: Colors.white,
          child: PhotoView(
            backgroundDecoration: BoxDecoration(color: Colors.white),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered,
            imageProvider:MemoryImage(base64Decode(photo.photo_name)),
          ),
        ),
      ),
    );
  }
}
