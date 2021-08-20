import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'common/device/network_info.dart';
import 'features/activities/data/datasources/remote/activity_remote_data_source.dart';
import 'features/activities/data/repositories/activity_repository.dart';
import 'features/activities/domain/repositories/i_activity_repository.dart';
import 'features/activities/domain/usecases/get_activity_by_type.dart';
import 'features/activities/domain/usecases/get_random_activity.dart';
import 'features/activities/presentation/states/activity_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Feature: Activity
  // Presentation
  sl.registerLazySingleton(() => ActivityBloc(sl(), sl()));
  // Domain
  sl.registerLazySingleton(() => GetRandomActivity(sl()));
  sl.registerLazySingleton(() => GetActivityByType(sl()));
  sl.registerLazySingleton<IActivityRepository>(() => ActivityRepository(sl()));
  // Data
  sl.registerLazySingleton<IActivityRemoteDataSource>(() => ActivityRemoteDataSource(sl(), sl()));

  //! Shared
  sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(sl()));

  //! External dependencies
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}
