import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderProv = context.watch<OrderProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Panel de Comandas')),
      body: orderProv.orders.isEmpty
          ? const Center(child: Text('No hay comandas pendientes.'))
          : ListView.builder(
              itemCount: orderProv.orders.length,
              itemBuilder: (context, index) {
                final order = orderProv.orders[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text('${order['studentName']} - ${order['course']}'),
                    subtitle: Text(
                      'Ticket: ${order['ticketCode']}\nEstado: ${order['status']}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () => orderProv.updateOrderStatus(
                            order['id'],
                            'Preparing',
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () => orderProv.updateOrderStatus(
                            order['id'],
                            'Rejected',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
