import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ApiProductRepository implements ProductRepository {
  // Usa 10.0.2.2 en el emulador de Android para acceder a localhost.
  // Si estás en Flutter Web (Chrome), usa localhost.
  // Si estás en un celular físico, usa la IP de tu PC (ej: 192.168.1.100).
  final String baseUrl;

  ApiProductRepository({this.baseUrl = 'http://localhost:8080'});

  @override
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map(
            (json) => Product(
              id: json['id'],
              categoryId:
                  json['categoryId'] ?? 1, // Ajusta según tu JSON del backend
              name: json['name'],
              description: json['description'] ?? '',
              price: json['price'].toDouble(),
              isAvailable:
                  json['isAvailable'] == true || json['isAvailable'] == 1,
            ),
          )
          .toList();
    } else {
      throw Exception('Error al cargar productos: ${response.statusCode}');
    }
  }

  @override
  Future<void> toggleAvailability(int productId, bool isAvailable) async {
    await http.patch(
      Uri.parse('$baseUrl/products/$productId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'isAvailable': isAvailable}),
    );
  }
}
