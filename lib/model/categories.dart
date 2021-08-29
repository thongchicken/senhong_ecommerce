
class SenHongCategory {
  final int id;
  final String name;
  final Image image;

  SenHongCategory({
    required this.id,
    required this.name,
    required this.image
  });

  factory SenHongCategory.fromJson(Map<String, dynamic> json) {
    return SenHongCategory(
      id: json['id'],
      name: json['name'],
      image: Image.fromJson(json['image']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
  };

}

class Image {

  final int id;
  final String src;

  Image({
    required this.id,
    required this.src
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(id: json['id'], src: json['src']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'src': src,
  };
}