// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:wallet_app/core/di/storage_module.dart' as _i413;
import 'package:wallet_app/core/helper/preference_helper.dart' as _i895;
import 'package:wallet_app/core/network/http_client.dart' as _i598;
import 'package:wallet_app/data/datasources/auth_remote_data_source.dart'
    as _i369;
import 'package:wallet_app/data/datasources/transaction_remote_data_source.dart'
    as _i859;
import 'package:wallet_app/data/datasources/wallet_remote_data_source.dart'
    as _i135;
import 'package:wallet_app/data/repositories/auth_repository_impl.dart' as _i40;
import 'package:wallet_app/data/repositories/transaction_repository_impl.dart'
    as _i709;
import 'package:wallet_app/data/repositories/wallet_repository_impl.dart'
    as _i759;
import 'package:wallet_app/domain/repositories/auth_repository.dart' as _i149;
import 'package:wallet_app/domain/repositories/transaction_repository.dart'
    as _i1070;
import 'package:wallet_app/domain/repositories/wallet_repository.dart'
    as _i1029;
import 'package:wallet_app/presentation/cubit/auth/auth_bloc.dart' as _i241;
import 'package:wallet_app/presentation/cubit/currency/currency_bloc.dart'
    as _i34;
import 'package:wallet_app/presentation/cubit/language/language_cubit.dart'
    as _i1047;
import 'package:wallet_app/presentation/cubit/theme/theme_cubit.dart' as _i817;
import 'package:wallet_app/presentation/cubit/transaction/transaction_bloc.dart'
    as _i1012;
import 'package:wallet_app/presentation/cubit/wallet/wallet_bloc.dart' as _i251;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final storageModule = _$StorageModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => storageModule.prefs(),
      preResolve: true,
    );
    gh.factory<_i1047.LanguageCubit>(() => _i1047.LanguageCubit());
    gh.factory<_i817.ThemeCubit>(() => _i817.ThemeCubit());
    gh.factory<_i34.CurrencyCubit>(() => _i34.CurrencyCubit());
    gh.lazySingleton<_i598.HttpClient>(() => _i598.HttpClient());
    gh.lazySingleton<_i895.PreferencesHelper>(() => _i895.PreferencesHelper(
        sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i135.WalletRemoteDataSource>(
        () => _i135.WalletRemoteDataSource(gh<_i598.HttpClient>()));
    gh.lazySingleton<_i859.TransactionRemoteDataSource>(
        () => _i859.TransactionRemoteDataSource(gh<_i598.HttpClient>()));
    gh.lazySingleton<_i369.AuthRemoteDataSource>(
        () => _i369.AuthRemoteDataSource(gh<_i598.HttpClient>()));
    gh.lazySingleton<_i149.AuthRepository>(
        () => _i40.AuthRepositoryImpl(gh<_i369.AuthRemoteDataSource>()));
    gh.factory<_i241.AuthCubit>(() => _i241.AuthCubit(
          gh<_i149.AuthRepository>(),
          gh<_i895.PreferencesHelper>(),
        ));
    gh.lazySingleton<_i1070.TransactionRepository>(() =>
        _i709.TransactionRepositoryImpl(
            gh<_i859.TransactionRemoteDataSource>()));
    gh.lazySingleton<_i1029.WalletRepository>(
        () => _i759.WalletRepositoryImpl(gh<_i135.WalletRemoteDataSource>()));
    gh.factory<_i1012.TransactionCubit>(
        () => _i1012.TransactionCubit(gh<_i1070.TransactionRepository>()));
    gh.factory<_i251.WalletCubit>(
        () => _i251.WalletCubit(gh<_i1029.WalletRepository>()));
    return this;
  }
}

class _$StorageModule extends _i413.StorageModule {}
