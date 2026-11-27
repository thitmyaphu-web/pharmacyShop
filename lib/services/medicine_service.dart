import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/medicine.dart';

class MedicineService {
  static const String _apiUrl =
      'https://www.themealdb.com/api/json/v1/1/search.php?s=cake';

  Future<List<Medicine>> fetchMedicines() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode != 200) {
      throw Exception('Failed to load cakes (${response.statusCode})');
    }

    final Map<String, dynamic> decoded =
        jsonDecode(response.body) as Map<String, dynamic>;
    final List<dynamic> meals = (decoded['meals'] as List<dynamic>?) ?? [];

    return meals.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value as Map<String, dynamic>;

      return Medicine(
        id: (item['idMeal'] ?? index).toString(),
        name: (item['strMeal'] ?? 'Cake').toString(),
        category: (item['strArea'] ?? item['strCategory'] ?? 'Dessert').toString(),
        unit: '1 Whole / Slice',
        price: 5000 + (index * 1500),
        stock: 15,
        requiresPrescription: false,
        description:
            (item['strInstructions'] ?? 'Freshly baked cake.').toString(),
        imageUrl: (item['strMealThumb'] ?? '').toString(),
      );
    }).toList();
  }
}