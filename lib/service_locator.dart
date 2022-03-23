import 'package:get_it/get_it.dart';
import 'package:tumble/resources/database/db/localStorageAPI.dart';
import 'package:tumble/resources/database/repository/schedule_repository.dart';

final GetIt locator = GetIt.instance;

Future setup() async {
  locator.registerSingletonAsync<LocalStorageService>(
      LocalStorageService().init());
}
