class ImageMetadata {
  final String id;
  final String url;
  final int width;
  final int height;

  ImageMetadata(this.id, this.url, this.width, this.height);

  ImageMetadata.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        url = json['url'],
        width = json['width'],
        height = json['height'];
}