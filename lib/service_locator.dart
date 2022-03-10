import 'package:get_it/get_it.dart';
import 'package:tumble/providers/localStorage.dart';

final GetIt locator = GetIt.instance;

Future setup() async {
  var localStorageService = LocalStorageService();
  await localStorageService.init();
  locator.registerSingleton<LocalStorageService>(localStorageService);
}
