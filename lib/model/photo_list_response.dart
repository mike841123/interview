class PhotoResponse {
  PhotoResponse({
    required this.mediaItems,
    required this.nextPageToken,
  });

  List<MediaItems> mediaItems;
  String nextPageToken;
}

class MediaItems {
  MediaItems({
    required this.id,
    required this.description,
    required this.baseUrl,
    required this.productUrl,
    required this.mimeType,
    required this.filename,
    required this.mediaMetadata,
    required this.contributorinfo,
  });

  int id;
  String description;
  String baseUrl;
  String productUrl;
  String mimeType;
  String filename;
  String mediaMetadata;
  String contributorinfo;
}

enum MimeType {
  image("image/jpeg"),
  video("video");

  const MimeType(this.value);

  final String value;
}
