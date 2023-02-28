import 'package:get_it/get_it.dart';
import 'package:send_me/core/repository/car_repo.dart';
import 'package:send_me/core/repository/firestore_repo.dart';
import 'package:send_me/core/services/auth_data_service.dart';
import 'package:send_me/core/services/navigation_service.dart';
import 'package:send_me/core/services/snackbar_services.dart';
import 'package:send_me/utils/progressBarManager/dialogService.dart';

import 'core/local_data_request/local_data_request.dart';
import 'core/repository/auth_repo.dart';
import 'core/services/notification_service.dart';
import 'data/network_request.dart';

final locator = GetIt.instance;

void setupServices() {
  //SERVICES LIKE STATE STORAGE
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<NotificationHelper>(() => NotificationHelper());
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<ProgressService>(() => ProgressService());
  locator.registerLazySingleton<SnackBarService>(() => SnackBarService());
  locator.registerLazySingleton<LocalDataRequest>(() => LocalDataRequest());
  // NETWORK
  locator.registerLazySingleton<NetworkProvider>(() => NetworkProviderImp());

  // NETWORK
  locator.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(locator()));
  locator.registerLazySingleton<FireStoreRepo>(() => FireStoreRepoImpl());
  locator.registerLazySingleton<CarRepo>(() => CarRepoImpl(locator()));
}
