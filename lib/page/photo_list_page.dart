import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poker_card/page/photo_content_page.dart';
import '../component/video_item.dart';
import '../model/photo_list_response.dart';

class PhotoListPage extends StatefulWidget {
  const PhotoListPage({super.key, required this.title});

  final String title;

  @override
  _PhotoListPageState createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  final ScrollController _scrollController = ScrollController(); // 監聽滾動
  List<MediaItems> mediaItems = []; // 資料回傳list
  String nextPageToken = ""; // 判斷是否有下一頁
  bool isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);  // 監聽滾動
    _getPhotosList(); 
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    /// 當nextPageToken為空時代表沒下一頁
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !isLoading && nextPageToken.isNotEmpty) {
      _getPhotosList();
    }
  }

  void _getPhotosList() async {
    setState(() {
      isLoading = true;
    });
    PhotoResponse response = await fetchPhotos(100);
    setState(() {
      mediaItems.addAll(response.mediaItems);
      nextPageToken = response.nextPageToken;
      page++;
      isLoading = false;
    });
  }

  /// 模擬api
  Future<PhotoResponse> fetchPhotos(int pageSize) async {
    return generateFakePhotoResponse(pageSize);
  }

  /// 假資料生成
  PhotoResponse generateFakePhotoResponse(int pageSize) {
    return PhotoResponse(
      mediaItems: List.generate(pageSize, (index) {
        return MediaItems(
          id: mediaItems.length + index + 1,
          description: 'Description ${mediaItems.length + index + 1}',

          /// 隨機塞影片
          baseUrl: index % 9 == 0
              ? 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
              : 'https://via.placeholder.com/300?text=Image${mediaItems.length + index + 1}',
          productUrl: 'https://example.com/image${mediaItems.length + index + 1}',
          mimeType: index % 9 == 0 ? 'video' : 'image/jpeg',
          filename: 'Image${mediaItems.length + index + 1}.jpg',
          mediaMetadata: 'Metadata ${mediaItems.length + index + 1}',
          contributorinfo: 'Contributor ${mediaItems.length + index + 1}',
        );
      }),
      nextPageToken: page <= 2 ? 'nextPageToken' : "", // 模擬到第二頁沒有下一頁的token
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: GridView.builder(
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemCount: mediaItems.length,
          itemBuilder: (context, index) {
            if (index < mediaItems.length) {
              final item = mediaItems[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PhotoContentPage(item: item)),
                  );
                },
                child: item.mimeType == MimeType.video.value
                    ? VideoItem(videoUrl: item.baseUrl)
                    : CachedNetworkImage(
                        errorWidget: (context, url, error) {
                          return const Icon(Icons.image_not_supported_outlined);
                        },
                        imageUrl: item.baseUrl,
                        fit: BoxFit.cover,
                      ),
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}
