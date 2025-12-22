import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Moneybox extends StatelessWidget {
  String title; 
  double amount; 
  double sizeConheight; 
  Color colorset; 
  double circular;

  Moneybox(this.title,this.amount,this.sizeConheight,this.colorset,this.circular);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeConheight,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: colorset,
        borderRadius: BorderRadius.circular(circular),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(), // 👈 ชิดขวา
          Text(
            '${NumberFormat("#,###,###").format(amount)} บาท',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
