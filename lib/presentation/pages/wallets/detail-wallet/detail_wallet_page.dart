import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_app/core/di/injector.dart';
import 'package:wallet_app/core/helper/text_helper.dart';
import 'package:wallet_app/l10n/languages.dart';
import 'package:wallet_app/presentation/cubit/wallet/wallet_bloc.dart';
import 'package:wallet_app/presentation/cubit/wallet/wallet_state.dart';
import 'package:wallet_app/presentation/pages/transactions/transaction_page.dart';
import 'package:wallet_app/presentation/pages/wallets/detail-wallet/widgets/balance_card.dart';

class DetailWalletPage extends StatelessWidget {
  final int id;
  const DetailWalletPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<WalletCubit>()..getDetailWallet(id: id.toString()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(Languages.of(context).wallet),
          centerTitle: true,
        ),
        body: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            if (state is GetDetailWalletLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetDetailWalletSuccess) {
              final wallet = state.data;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderCard(
                      walletId: wallet.id,
                      balance: wallet.balance.toDouble(),
                      currency: wallet.currency,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10),
                      child: Text(
                        Languages.of(context).listTransactions,
                        style: getTextStyle(
                            context: context,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    TransactionPage(walletId: wallet.id)
                  ],
                ),
              );
            } else if (state is WalletError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return Text('Error: }');
          },
        ),
      ),
    );
  }
}
