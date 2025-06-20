import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_app/core/router/router_name.dart';
import 'package:wallet_app/presentation/cubit/wallet/wallet_bloc.dart';
import 'package:wallet_app/presentation/cubit/wallet/wallet_state.dart';
import 'package:wallet_app/presentation/pages/wallets/widgets/balance_card.dart';
import 'package:wallet_app/l10n/languages.dart';

class WalletList extends StatelessWidget {
  const WalletList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        if (state is WalletLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is WalletSuccess) {
          final wallets = state.data;
          return Column(
            children: [
              if (wallets.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      Languages.of(context).noWalletFound,
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ),
                )
              else
                Column(
                  children: List.generate(
                      wallets.length,
                      (i) => BalanceCard(
                            onTap: () {
                              context.pushNamed(detailWallet,
                                  extra: wallets[i].id);
                            },
                            balance: wallets[i].balance.toDouble(),
                            currency: wallets[i].currency,
                          )),
                )
            ],
          );
        } else if (state is WalletError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return SizedBox.shrink();
      },
    );
  }
}
