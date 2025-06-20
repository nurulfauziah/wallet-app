import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/core/di/injector.dart';
import 'package:wallet_app/presentation/cubit/transaction/transaction_bloc.dart';
import 'package:wallet_app/presentation/cubit/transaction/transaction_state.dart';
import 'package:wallet_app/presentation/pages/transactions/detail/widgets/detai_trx_header.dart';
import 'package:wallet_app/presentation/pages/transactions/detail/widgets/detail_summary_card.dart';

class DetailTransactionPage extends StatelessWidget {
  const DetailTransactionPage({
    super.key,
    required this.data,
  });

  final DetailTransaction data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TransactionCubit>()
        ..getDetail(walletId: data.walletId, id: data.transationId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Transaction Details"),
          centerTitle: true,
        ),
        body: BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            if (state is GetDetailTransactionSuccess) {
              final detail = state.data;
              final date = DateTime.parse(detail.timestamp);
              final List<Map<String, String>> details = [
                {"title": "Type", "value": detail.type},
                {"title": "Amount", "value": 'USD ${detail.amount}'},
                {"title": "Time", "value": DateFormat('HH:mm').format(date)},
                {
                  "title": "Date",
                  "value": DateFormat('dd MMM yyyy').format(date)
                },
              ];

              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailTrxHeaderWidget(
                      type: detail.type,
                      date: DateTime.parse(detail.timestamp),
                    ),
                    const SizedBox(height: 24),
                    DetailSummaryCard(
                      details: details,
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              );
            }

            if (state is GetDetailTransactionError) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<TransactionCubit>().getDetail(
                          walletId: data.walletId,
                          id: data.transationId,
                        );
                  },
                  child: const Text('Try Again'),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class DetailTransaction {
  final int walletId;
  final int transationId;

  DetailTransaction({required this.transationId, required this.walletId});
}
