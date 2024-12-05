import 'package:pam1/domain/entities/drink.dart';

class DrinkModel extends Drink {
  DrinkModel({
    required String name,
    required String type,
    required String origin,
    required int price,
    required bool isAvailable,
    required int criticsScore,
    required List<String> tags,
    required String imagePath,
    bool isFavorite = false,
  }) : super(
    name: name,
    type: type,
    origin: origin,
    price: price,
    isAvailable: isAvailable,
    criticsScore: criticsScore,
    tags: tags,
    imagePath: imagePath,
    isFavorite: isFavorite,
  );

  factory DrinkModel.fromJson(Map<String, dynamic> json) {
    return DrinkModel(
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'origin': origin,
      'price': price,
      'isAvailable': isAvailable,
      'criticsScore': criticsScore,
      'tags': tags,
      'imagePath': imagePath,
      'isFavorite': isFavorite,
    };
  }
}
