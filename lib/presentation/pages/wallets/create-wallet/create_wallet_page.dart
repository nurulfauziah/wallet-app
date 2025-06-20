import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_app/core/di/injector.dart';
import 'package:wallet_app/core/helper/text_helper.dart';
import 'package:wallet_app/core/router/router_name.dart';
import 'package:wallet_app/core/widgets/main_dialog.dart';
import 'package:wallet_app/core/widgets/main_page_subtitle.dart';
import 'package:wallet_app/core/widgets/main_page_title.dart';
import 'package:wallet_app/presentation/cubit/wallet/wallet_bloc.dart';
import 'package:wallet_app/presentation/cubit/wallet/wallet_state.dart';
import 'package:wallet_app/presentation/pages/wallets/create-wallet/widgets/form.dart';
import 'package:wallet_app/l10n/languages.dart';

class CreateWalletPage extends StatelessWidget {
  const CreateWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WalletCubit>(),
      child: BlocListener<WalletCubit, WalletState>(
        listener: (context, state) {
          if (state is CreateWalletSuccess) {
            MainDialog().dialogInfo(
              context,
              title: Languages.of(context).walletCreated,
              subtitle: Languages.of(context).walletCreatedSuccessfully,
              onTap: () {
                context.pushNamed(wallet);
              },
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(Languages.of(context).createWallet),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainPageTitle(title: Languages.of(context).createWallet),
                  const SizedBox(
                    height: 8.0,
                  ),
                  MainPageSubtitle(
                      subtitle: Languages.of(context).fillDetailsToRegister),
                  SizedBox(height: 20),
                  CreateWalletForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
