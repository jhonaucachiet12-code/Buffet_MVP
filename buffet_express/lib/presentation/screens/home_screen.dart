// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive_layout.dart';
import '../providers/cart_provider.dart';
import 'products_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      'id': 1,
      'name': 'Bebidas',
      'desc': 'Aguas, jugos y gaseosas',
      'icon': Icons.local_drink,
      'color': const Color(0xFFE0F2F1),
    },
    {
      'id': 2,
      'name': 'Snacks',
      'desc': 'Algo rico para tu recreo',
      'icon': Icons.cookie,
      'color': const Color(0xFFFFF3E0),
    },
    {
      'id': 3,
      'name': 'Menús',
      'desc': 'Opciones para el almuerzo',
      'icon': Icons.restaurant,
      'color': const Color(0xFFF3E5F5),
    },
  ];

  Widget _buildCategoryCard(BuildContext context, Map<String, dynamic> cat) {
    return Card(
      color: cat['color'],
      elevation: 0,
      child: ListTile(
        leading: Icon(cat['icon'], color: AppTheme.darkGreen, size: 30),
        title: Text(
          cat['name'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(cat['desc']),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                ProductsScreen(categoryId: cat['id'], title: cat['name']),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    // Contenido del encabezado verde
    final headerContent = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.darkGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¿Qué pinta para el recreo?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Elegí algo rico y armá tu pedido.',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );

    // 1. DISEÑO MÓVIL (Lista vertical)
    final mobileBody = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerContent,
          const SizedBox(height: 20),
          const Text(
            '¿Qué vas a pedir?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildCategoryCard(context, categories[index]),
              ),
            ),
          ),
        ],
      ),
    );

    // 2. DISEÑO ESCRITORIO (Grilla horizontal y menú superior)
    final desktopBody = Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerContent,
          const SizedBox(height: 30),
          const Text(
            '¿Qué vas a pedir?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 columnas en PC
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 3, // Ajusta la altura de las tarjetas
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) =>
                  _buildCategoryCard(context, categories[index]),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buffet escolar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.lightBeige,
        elevation: 0,
        actions: [
          // En escritorio, mostramos el carrito arriba a la derecha
          if (cart.itemCount > 0)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: Badge(
                  label: Text('${cart.itemCount}'),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: AppTheme.darkGreen,
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CartScreen()),
                ),
              ),
            ),
        ],
      ),
      body: ResponsiveLayout(mobileBody: mobileBody, desktopBody: desktopBody),
      // En móvil mostramos la barra inferior
      bottomNavigationBar:
          MediaQuery.of(context).size.width < 800 && cart.itemCount > 0
          ? Container(
              padding: const EdgeInsets.all(16),
              color: AppTheme.darkGreen,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${cart.itemCount} productos • \$${cart.total.toStringAsFixed(0)}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CartScreen()),
                    ),
                    child: const Text(
                      'Ver carrito',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
