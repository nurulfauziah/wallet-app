import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_app/core/helper/colors_helper.dart';
import 'package:wallet_app/core/helper/text_helper.dart';
import 'package:wallet_app/core/router/router_name.dart';
import 'package:wallet_app/core/widgets/main_button.dart';
import 'package:wallet_app/l10n/languages.dart';

class HeaderCard extends StatelessWidget {
  final double balance;
  final String currency;
  final int walletId;

  const HeaderCard({
    super.key,
    required this.balance,
    required this.walletId,
    this.currency = 'USD',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.deepPurple.shade50,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Languages.of(context).totalBalance,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: baseColor,
                                )),
                        const SizedBox(height: 8),
                        Text(
                          '$currency ${balance.toStringAsFixed(2)}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: baseColor,
                              ),
                        ),
                      ]),
                  Image.asset(
                    'assets/icons/ic_wallet.png',
                    width: 50,
                    color: Colors.deepPurple.shade200,
                  )
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: MainButton(
                      onTap: () {
                        context.pushNamed(deposit, extra: walletId);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 22,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 3.0,
                          ),
                          Text(
                            Languages.of(context).deposit,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                    ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: MainButton(
                      onTap: () {
                        context.pushNamed(withdrawal, extra: walletId);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_downward,
                            size: 22,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 3.0,
                          ),
                          Text(
                            Languages.of(context).withdrawal,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                    ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
