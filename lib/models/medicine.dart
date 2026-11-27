class Medicine {
  final String id;
  final String name;
  final String category;
  final String unit;
  final int price;
  final int stock;
  final bool requiresPrescription;
  final String description;
  final String imageUrl;

  const Medicine({
    required this.id,
    required this.name,
    required this.category,
    required this.unit,
    required this.price,
    required this.stock,
    required this.requiresPrescription,
    required this.description,
    this.imageUrl = '',
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    final rawPrice = json['price'];
    final parsedPrice = rawPrice is num ? rawPrice.round() : 5000;

    final rawStock = json['stock'];
    final parsedStock = rawStock is num ? rawStock.toInt() : 15;

    return Medicine(
      id: (json['idMeal'] ?? json['id'] ?? '').toString(),
      name: (json['strMeal'] ?? json['name'] ?? 'Cake').toString(),
      category: (json['strCategory'] ?? json['category'] ?? 'Dessert').toString(),
      unit: (json['unit'] ?? '1 Whole / Slice').toString(),
      price: parsedPrice,
      stock: parsedStock,
      requiresPrescription: false,
      description:
          (json['strInstructions'] ?? json['description'] ?? 'Freshly baked cake.')
              .toString(),
      imageUrl: (json['strMealThumb'] ?? json['imageUrl'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'unit': unit,
      'price': price,
      'stock': stock,
      'requiresPrescription': requiresPrescription,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  Medicine copyWith({int? stock}) {
    return Medicine(
      id: id,
      name: name,
      category: category,
      unit: unit,
      price: price,
      stock: stock ?? this.stock,
      requiresPrescription: requiresPrescription,
      description: description,
      imageUrl: imageUrl,
    );
  }
}