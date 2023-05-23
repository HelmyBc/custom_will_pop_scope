
import 'package:example/navigation_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
   locator.registerLazySingleton<NavigationService>(() => NavigationService());
}
