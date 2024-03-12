class ImageModel {
  int? imageId;
  String? imagePath;

  ImageModel({
    this.imageId,
    this.imagePath,
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageId'] = imageId;
    data['imagePath'] = imagePath;
    return data;
  }

  dynamic operator [](String key) {
    switch (key) {
      case 'imageId':
        return imageId;
      case 'imagePath':
        return imagePath;
      default:
        return null;
    }
  }
}
