class Images {
  final int id;
  final String src;

  Images({required this.id, required this.src});

  factory Images.fromJson(Map<String, dynamic> json){
    return Images(id: json['id'], src: json['src']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'src': src,
  };
}