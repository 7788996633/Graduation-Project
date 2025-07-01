import 'package:flutter/material.dart';

class OrdersTable extends StatelessWidget {
  const OrdersTable({super.key});

  final List<Order> orders = const [
    Order(invoice: '12386', customer: 'Charly Duos', from: 'Brazil', price: 299, status: 'Process', color: Colors.red),
    Order(invoice: '12386', customer: 'Marko', from: 'Italy', price: 2642, status: 'Open', color: Colors.green),
    Order(invoice: '12386', customer: 'Denyel Onak', from: 'Russia', price: 981, status: 'On Hold', color: Colors.orange),
    Order(invoice: '12386', customer: 'Belgin Bastana', from: 'Korea', price: 369, status: 'Process', color: Colors.red),
    Order(invoice: '12386', customer: 'Sarti Onuska', from: 'Japan', price: 1240, status: 'Open', color: Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Order Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 20),
          DataTable(
            columns: const [
              DataColumn(label: Text('Invoice')),
              DataColumn(label: Text('Customer')),
              DataColumn(label: Text('From')),
              DataColumn(label: Text('Price')),
              DataColumn(label: Text('Status')),
            ],
            rows: orders.map((order) {
              return DataRow(cells: [
                DataCell(Text(order.invoice)),
                DataCell(Text(order.customer)),
                DataCell(Text(order.from)),
                DataCell(Text('\$${order.price}')),
                DataCell(Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: order.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(order.status, style: TextStyle(color: order.color)),
                )),
              ]);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class Order {
  final String invoice;
  final String customer;
  final String from;
  final int price;
  final String status;
  final Color color;

  const Order({
    required this.invoice,
    required this.customer,
    required this.from,
    required this.price,
    required this.status,
    required this.color,
  });
}
