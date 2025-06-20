import 'package:flutter/material.dart';
import 'package:wallet_app/core/helper/colors_helper.dart';

class BalanceCard extends StatelessWidget {
  final Function()? onTap;
  final double balance;
  final double? height;
  final String currency;

  const BalanceCard({
    super.key,
    required this.balance,
    this.currency = 'USD',
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Colors.deepPurple.shade50,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/icons/ic_wallet.png',
                      color: Theme.of(context).primaryColor,
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Balance',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: baseColor,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$currency ${balance.toStringAsFixed(2)}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: baseColor,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
