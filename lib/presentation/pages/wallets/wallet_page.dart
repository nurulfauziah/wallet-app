import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_app/core/di/injector.dart';
import 'package:wallet_app/core/helper/text_helper.dart';
import 'package:wallet_app/l10n/languages.dart';
import 'package:wallet_app/presentation/cubit/wallet/wallet_bloc.dart';
import 'package:wallet_app/presentation/pages/wallets/widgets/header_wallet.dart';
import 'package:wallet_app/presentation/pages/wallets/widgets/list_wallet.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WalletCubit>()..load(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWallet(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                child: Text(
                  Languages.of(context).listWallet,
                  style: getTextStyle(
                      context: context,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              WalletList(),
            ],
          ),
        ),
      ),
    );
  }
}
