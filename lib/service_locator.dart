import 'package:get_it/get_it.dart';
import 'package:tumble/providers/theme_provider.dart';

final GetIt locator = GetIt.instance;

Future<void> setup() async {
  ThemeProvider themeProvider = await ThemeProvider.init();
  locator.registerSingleton(themeProvider);
}
