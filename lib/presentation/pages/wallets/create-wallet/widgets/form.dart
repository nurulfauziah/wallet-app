import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_app/core/enums/currency_enum.dart';
import 'package:wallet_app/core/helper/formatter_helper.dart';
import 'package:wallet_app/core/widgets/main_button.dart';
import 'package:wallet_app/core/widgets/main_dropdown.dart';
import 'package:wallet_app/core/widgets/main_textfield.dart';
import 'package:wallet_app/presentation/cubit/currency/currency_bloc.dart';
import 'package:wallet_app/presentation/cubit/wallet/wallet_bloc.dart';
import 'package:wallet_app/presentation/cubit/wallet/wallet_state.dart';
import 'package:wallet_app/l10n/languages.dart';

class CreateWalletForm extends StatefulWidget {
  const CreateWalletForm();

  @override
  State<CreateWalletForm> createState() => CreateWalletFormState();
}

class CreateWalletFormState extends State<CreateWalletForm> {
  final _initialBalance = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final selectedCurrency = context.read<CurrencyCubit>().state;
      final initialBalance =
          double.tryParse(_initialBalance.text.replaceAll(',', '')) ?? 0.0;

      context.read<WalletCubit>().createWallet(
            currency: selectedCurrency?.label ?? "USD",
            initialBalance: initialBalance,
          );
    }
  }

  @override
  void dispose() {
    _initialBalance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is CreateWalletLoading,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                BlocBuilder<CurrencyCubit, CurrencyType?>(
                  builder: (context, selectedCurrency) {
                    return MainDropdown(
                      formLabel: "Currency",
                      selectedValue: selectedCurrency,
                      onChanged: (value) {
                        context
                            .read<CurrencyCubit>()
                            .selectCurrency(value as CurrencyType);
                      },
                      items: CurrencyType.values
                          .map((currency) => DropdownMenuItem(
                                value: currency,
                                child: Text(currency.label),
                              ))
                          .toList(),
                    );
                  },
                ),
                const SizedBox(height: 16),
                MainTextFormField(
                  labelText: Languages.of(context).initialBalance,
                  controller: _initialBalance,
                  keyboardType: TextInputType.number,
                  inputFormatters: [CurrencyInputFormatter()],
                ),
                const SizedBox(height: 16),
                MainButton(
                  onTap: state is CreateWalletLoading ? null : _onSubmit,
                  title: state is CreateWalletLoading
                      ? 'Loading...'
                      : Languages.of(context).createWallet,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
