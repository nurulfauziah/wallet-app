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

class DepositPage extends StatefulWidget {
  const DepositPage({super.key, required this.walletId});
  final int walletId;

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
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
          if (state is PostDepositSuccess) {
            context.pushNamed(wallet);
          } else if (state is PostDepositError) {}
          // TODO: implement listener
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(Languages.of(context).deposit),
            centerTitle: true,
            actions: const [],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                MainPageTitle(title: Languages.of(context).deposit),
                const SizedBox(height: 8.0),
                MainPageSubtitle(
                  subtitle: Languages.of(context).depositSubtitle,
                ),
                const SizedBox(
                  height: 16.0,
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
                      title: state is PostDepositLoading
                          ? Languages.of(context).loading
                          : Languages.of(context).continueText,
                      onTap: state is PostDepositLoading
                          ? null
                          : () {
                              context.read<TransactionCubit>().postDeposit(
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
