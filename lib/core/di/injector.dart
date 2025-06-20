import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector.config.dart'; // hasil generate build_runner

final getIt = GetIt.instance;

@injectableInit
Future<void> setupLocator() async {
  await getIt.init();
}
