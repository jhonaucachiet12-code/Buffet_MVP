// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Tu Carrito')),
      body: cart.items.isEmpty
          ? const Center(child: Text('Tu carrito está vacío'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items.values.toList()[index];
                      return ListTile(
                        title: Text(item.product.name),
                        subtitle: Text('Cantidad: ${item.quantity}'),
                        trailing: Text(
                          '\$${(item.product.price * item.quantity).toStringAsFixed(0)}',
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: AppTheme.lightBeige,
                  child: Column(
                    children: [
                      Text(
                        'Total: \$${cart.total.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Simulación de pedido para probar el flujo
                            context.read<OrderProvider>().createOrder(
                              'Alex García',
                              '3° 1°',
                              'MercadoPago',
                              cart.total,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('¡Pedido realizado!'),
                              ),
                            );
                            Navigator.popUntil(
                              context,
                              (route) => route.isFirst,
                            );
                          },
                          child: const Text('Confirmar Pedido'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
