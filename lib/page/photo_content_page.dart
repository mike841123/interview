import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../component/video_item.dart';
import '../model/photo_list_response.dart';

class PhotoContentPage extends StatelessWidget {
  const PhotoContentPage({super.key, required this.item});

  final MediaItems item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("詳情"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: item.mimeType == MimeType.image.value
                  ? CachedNetworkImage(
                      imageUrl: item.baseUrl,
                      fit: BoxFit.fitWidth,
                    )
                  : VideoItem(videoUrl: item.baseUrl),
            ),
            Expanded(child: Text("描述：${item.description}"))
          ],
        ),
      ),
    );
  }
}
