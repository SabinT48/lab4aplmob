class Drink {
  final String name;
  final String type;
  final String origin;
  final int price;
  final bool isAvailable;
  final int criticsScore;
  final List<String> tags;
  final String imagePath;
  bool isFavorite;

  Drink({
    required this.name,
    required this.type,
    required this.origin,
    required this.price,
    required this.isAvailable,
    required this.criticsScore,
    required this.tags,
    required this.imagePath,
    this.isFavorite = false,
  });

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      name: json['name'],
      type: json['type'],
      origin: json['origin'],
      price: json['price'],
      isAvailable: json['isAvailable'],
      criticsScore: json['criticsScore'],
      tags: List<String>.from(json['tags']),
      imagePath: json['imagePath'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
