import 'package:flutter/material.dart';

class OrdersTable extends StatelessWidget {
  final Color cardColor;

  const OrdersTable({super.key, required this.cardColor});

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
      decoration: BoxDecoration(
        color: cardColor, // استخدم اللون المرسل من الخارج
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Status',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: cardColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
              )),
          const SizedBox(height: 20),
          DataTable(
            columns: [
              DataColumn(label: Text('Invoice', style: TextStyle(color: cardColor.computeLuminance() > 0.5 ? Colors.black : Colors.white))),
              DataColumn(label: Text('Customer', style: TextStyle(color: cardColor.computeLuminance() > 0.5 ? Colors.black : Colors.white))),
              DataColumn(label: Text('From', style: TextStyle(color: cardColor.computeLuminance() > 0.5 ? Colors.black : Colors.white))),
              DataColumn(label: Text('Price', style: TextStyle(color: cardColor.computeLuminance() > 0.5 ? Colors.black : Colors.white))),
              DataColumn(label: Text('Status', style: TextStyle(color: cardColor.computeLuminance() > 0.5 ? Colors.black : Colors.white))),
            ],
            rows: orders.map((order) {
              return DataRow(cells: [
                DataCell(Text(order.invoice, style: TextStyle(color: cardColor.computeLuminance() > 0.5 ? Colors.black : Colors.white))),
                DataCell(Text(order.customer, style: TextStyle(color: cardColor.computeLuminance() > 0.5 ? Colors.black : Colors.white))),
                DataCell(Text(order.from, style: TextStyle(color: cardColor.computeLuminance() > 0.5 ? Colors.black : Colors.white))),
                DataCell(Text('\$${order.price}', style: TextStyle(color: cardColor.computeLuminance() > 0.5 ? Colors.black : Colors.white))),
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
