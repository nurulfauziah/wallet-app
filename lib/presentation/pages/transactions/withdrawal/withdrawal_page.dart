import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_app/core/di/injector.dart';
import 'package:wallet_app/core/helper/formatter_helper.dart';
import 'package:wallet_app/core/router/router_name.dart';
import 'package:wallet_app/core/widgets/main_button.dart';
import 'package:wallet_app/core/widgets/main_page_subtitle.dart';
import 'package:wallet_app/core/widgets/main_page_title.dart';
import 'package:wallet_app/core/widgets/main_textfield.dart';
import 'package:wallet_app/presentation/cubit/transaction/transaction_bloc.dart';
import 'package:wallet_app/presentation/cubit/transaction/transaction_state.dart';
import 'package:wallet_app/l10n/languages.dart';

class WithdrawalPage extends StatefulWidget {
  const WithdrawalPage({super.key, required this.walletId});
  final int walletId;

  @override
  State<WithdrawalPage> createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  final TextEditingController _amount = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _amount.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TransactionCubit>(),
      child: BlocListener<TransactionCubit, TransactionState>(
        listener: (context, state) {
          if (state is PostWithdrawalSuccess) {
            context.pushNamed(wallet);
          } else if (state is PostWithdrawalError) {}
          // TODO: implement listener
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(Languages.of(context).withdrawal),
            actions: const [],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainPageTitle(title: Languages.of(context).withdrawal),
                const SizedBox(height: 8.0),
                MainPageSubtitle(
                  subtitle: Languages.of(context).withdrawalSubtitle,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                MainTextFormField(
                  labelText: Languages.of(context).amount,
                  controller: _amount,
                  keyboardType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter()],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                BlocBuilder<TransactionCubit, TransactionState>(
                  builder: (context, state) {
                    return MainButton(
                      title: state is PostWithdrawalLoading
                          ? 'Loading...'
                          : Languages.of(context).continueText,
                      onTap: state is PostWithdrawalLoading
                          ? null
                          : () {
                              context.read<TransactionCubit>().postWithdrawal(
                                  amount: num.parse(
                                      _amount.text.replaceAll(',', '')),
                                  walletId: widget.walletId);
                            },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
