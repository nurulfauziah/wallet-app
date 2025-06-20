import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_app/core/enums/currency_enum.dart';
import 'package:injectable/injectable.dart';

@injectable
class CurrencyCubit extends Cubit<CurrencyType?> {
  CurrencyCubit() : super(CurrencyType.usd);

  void selectCurrency(CurrencyType? currency) => emit(currency);
}
