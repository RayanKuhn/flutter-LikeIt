class ImageModel {
  final String id;
  final String author;
  final String imageUrl;

  ImageModel({required this.id, required this.author, required this.imageUrl});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      author: json['user']['name'],
      imageUrl: json['urls']['regular'],
    );
  }
}
