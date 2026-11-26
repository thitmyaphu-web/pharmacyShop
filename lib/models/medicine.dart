class Medicine {
  final String id;
  final String name;
  final String category;
  final String unit;
  final int price;
  final int stock;
  final bool requiresPrescription;
  final String description;

  const Medicine({
    required this.id,
    required this.name,
    required this.category,
    required this.unit,
    required this.price,
    required this.stock,
    required this.requiresPrescription,
    required this.description,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      unit: json['unit'] as String,
      price: json['price'] as int,
      stock: json['stock'] as int,
      requiresPrescription: json['requiresPrescription'] as bool,
      description: json['description'] as String,
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
    );
  }
}