import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/core/di/injector.dart';
import 'package:wallet_app/core/helper/text_helper.dart';
import 'package:wallet_app/core/router/router_name.dart';
import 'package:wallet_app/core/widgets/main_card.dart';
import 'package:wallet_app/presentation/cubit/transaction/transaction_bloc.dart';
import 'package:wallet_app/presentation/cubit/transaction/transaction_state.dart';
import 'package:wallet_app/presentation/pages/transactions/detail/detail_transaction_page.dart';
import 'package:wallet_app/l10n/languages.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key, required this.walletId});
  final int walletId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<TransactionCubit>()..load(walletId: walletId, page: 1),
      child: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          if (state is GetListTransactionLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetListTransactionSuccess) {
            if (state.data.transactions.isEmpty) {
              return Expanded(
                child: Center(
                  child: Text(
                    Languages.of(context).noTransactionFound,
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.data.transactions.length,
                  itemBuilder: (_, i) => CardMenu(
                    onTap: () => context.pushNamed(detailTransaction,
                        extra: DetailTransaction(
                            transationId: state.data.transactions[i].id,
                            walletId: walletId)),
                    title:
                        "${state.data.transactions[i].type == 'WITHDRAWAL' ? '-' : '+'} USD ${state.data.transactions[i].amount ?? '-'}",
                    subtitle: DateFormat('dd MMM yyyy')
                        .format(state.data.transactions[i].timestamp),
                    trailingWidget: Text(
                      state.data.transactions[i].type ?? '-',
                    ),
                    titleStyle: getTextStyle(
                        context: context,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }
          } else if (state is GetListTransactionError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
