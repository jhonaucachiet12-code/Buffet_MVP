// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../providers/cart_provider.dart';

class ProductsScreen extends StatefulWidget {
  final int categoryId;
  final String title;
  ProductsScreen({required this.categoryId, required this.title});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    final repo = context.read<ProductRepository>();
    _productsFuture = repo.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          final products = snapshot.data!
              .where((p) => p.categoryId == widget.categoryId)
              .toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  title: Text(
                    p.name,
                    style: TextStyle(
                      color: p.isAvailable ? Colors.black : Colors.grey,
                    ),
                  ),
                  subtitle: Text('${p.description} • \$${p.price}'),
                  trailing: p.isAvailable
                      ? IconButton(
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.green,
                          ),
                          onPressed: () =>
                              context.read<CartProvider>().addProduct(p),
                        )
                      : const Text(
                          'Agotado',
                          style: TextStyle(color: Colors.red),
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
