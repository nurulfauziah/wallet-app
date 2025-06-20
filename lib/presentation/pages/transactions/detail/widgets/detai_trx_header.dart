import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailTrxHeaderWidget extends StatelessWidget {
  final String type;
  final DateTime date;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const DetailTrxHeaderWidget({
    Key? key,
    required this.type,
    required this.date,
    this.icon = Icons.receipt_long,
    this.iconColor = Colors.blue,
    this.backgroundColor = const Color(0xffE6F1FB),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: 53,
            width: 53,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 24, color: iconColor),
          ),
          const SizedBox(height: 16),
          Text(
            type,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('dd MMM yyyy').format(date),
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(width: 8),
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                DateFormat('HH:mm').format(date),
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          )
        ],
      ),
    );
  }
}
