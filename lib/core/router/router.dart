import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_app/core/router/router_name.dart';
import 'package:wallet_app/core/widgets/main_scaffold.dart';
import 'package:wallet_app/presentation/pages/login/login_page.dart';
import 'package:wallet_app/presentation/pages/register/register_page.dart';
import 'package:wallet_app/presentation/pages/settings/settings_page.dart';
import 'package:wallet_app/presentation/pages/transactions/deposit/deposit_page.dart';
import 'package:wallet_app/presentation/pages/transactions/detail/detail_transaction_page.dart';
import 'package:wallet_app/presentation/pages/transactions/withdrawal/withdrawal_page.dart';
import 'package:wallet_app/presentation/pages/wallets/create-wallet/create_wallet_page.dart';
import 'package:wallet_app/presentation/pages/wallets/detail-wallet/detail_wallet_page.dart';
import 'package:wallet_app/presentation/pages/wallets/wallet_page.dart';
import 'package:wallet_app/splash_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
        path: '/',
        name: splash,
        builder: (context, state) => const SplashPage(),
        routes: const []),
    GoRoute(
        path: '/login',
        name: login,
        builder: (context, state) => const LoginPage(),
        routes: const []),
    GoRoute(
        path: '/register',
        name: register,
        builder: (context, state) => const RegisterPage(),
        routes: const []),
    GoRoute(
        path: '/wallet',
        name: wallet,
        builder: (context, state) => MainScaffold(child: const WalletPage()),
        routes: [
          GoRoute(
            path: '/$deposit',
            name: deposit,
            builder: (context, state) => DepositPage(
              walletId: state.extra as int,
            ),
          ),
          GoRoute(
            path: '/$withdrawal',
            name: withdrawal,
            builder: (context, state) => WithdrawalPage(
              walletId: state.extra as int,
            ),
          ),
          GoRoute(
            path: '/$detailTransaction',
            name: detailTransaction,
            builder: (context, state) => DetailTransactionPage(
              data: state.extra as DetailTransaction,
            ),
          ),
          GoRoute(
              path: '/$createWallet',
              name: createWallet,
              builder: (context, state) => const CreateWalletPage(),
              routes: const []),
          GoRoute(
              path: '/$detailWallet',
              name: detailWallet,
              builder: (context, state) => DetailWalletPage(
                    id: state.extra as int,
                  ),
              routes: const []),
        ]),
    GoRoute(
        path: '/settings',
        name: settings,
        builder: (context, state) => MainScaffold(child: const SettingsPage()),
        routes: []),
    GoRoute(
        path: '/restricted',
        name: restricted,
        builder: (context, state) => const SettingsPage()),
  ],
);
