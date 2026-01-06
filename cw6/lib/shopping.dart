import 'package:flutter/material.dart';

class formShopping extends StatelessWidget {
  const formShopping({
    super.key,
    required this.productName,
    required this.customerName,
    required this.productNumber,
  });

  final String productName;
  final String customerName;
  final int productNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Summary'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 80,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Order Successful',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(height: 32, thickness: 1),

                ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: const Text('Product Name'),
                  subtitle: Text(productName),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Customer Name'),
                  subtitle: Text(customerName),
                ),
                ListTile(
                  leading: const Icon(Icons.format_list_numbered),
                  title: const Text('Number of Product'),
                  subtitle: Text(productNumber.toString()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
