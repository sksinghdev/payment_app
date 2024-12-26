// ignore_for_file: depend_on_referenced_packages
import 'package:get_it/get_it.dart';
import 'package:payment_demo/core/connection_helper.dart';
import 'package:payment_demo/core/fuctions.dart';
import 'package:payment_demo/features/login/data/repositories/login_repository_impl.dart';
import 'package:payment_demo/features/transaction/data/datasource/history_datasource.dart';
import 'package:payment_demo/features/transaction/data/datasource/local/history_database_provider.dart';
import 'package:payment_demo/features/transaction/data/datasource/local/history_datatbase_service.dart';
import 'package:payment_demo/features/transaction/data/mapper/history_domain_mapper.dart';
import 'package:payment_demo/features/transaction/data/repositories/login_repository_impl.dart';
import 'package:payment_demo/features/transaction/doamin/repositories/history_repository.dart';
import 'package:payment_demo/features/transaction/doamin/usecases/history_usecase.dart';
import '../features/login/data/datasources/local/login_database_provider.dart';
import '../features/login/data/datasources/local/login_database_service.dart';
import '../features/login/data/datasources/remote/login_data_source.dart';
import '../features/login/data/mapper/login_domain_mapper.dart';
import '../features/login/domain/repositories/login_repository.dart';
import '../features/login/domain/usecases/login_use_case.dart';
import '../features/login/presentation/bloc/login_cubit.dart';
import '../features/login/presentation/entities/login_user_ui_model.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../features/transaction/data/entities/history_domain_model.dart';
import '../features/transaction/presentation/bloc/history_cubit.dart';

GetIt injector = GetIt.instance;
setupDependencies() async {
  /// internet helper
  injector.registerSingleton(InternetConnectionHelper());

  /// Hive
  await Hive.initFlutter();

  /// DB Services
  injector.registerFactory<LoginDataBaseService>(
    () => LoginDataBaseService(),
  );
  await injector<LoginDataBaseService>().initDataBase();

  /// DataBase Providers
  injector.registerFactory<LoginDataBaseProvider>(
    () => LoginDataBaseProvider(
      loginDataBaseService: injector(),
    ),
  );

  /// remote data source
  injector.registerFactory<LoginRemoteDataSource>(
    () => LoginRemoteDataSource(injector(), injector()),
  );

  /// repository
  injector.registerFactory<LoginRepository>(
    () => LoginRepositoryImpl(
      injector(),
    ),
  );

  /// usecase
  injector.registerLazySingleton<LoginUseCase>(() => LoginUseCase(
        loginRepo: injector(),
      ));

  /// mapper
  injector.registerFactory<Function2<Response?, String, UserUIModel?>>(
    () => LoginDomainMapper(),
  );

  /// cubit
  injector.registerFactory<LoginCubit>(() => LoginCubit(injector()));

  /// DB Services
  injector.registerFactory<HistoryDataBaseService>(
    () => HistoryDataBaseService(),
  );
  await injector<HistoryDataBaseService>().initDataBase();

  /// DataBase Providers
  injector.registerFactory<HistoryDataBaseProvider>(
    () => HistoryDataBaseProvider(
      historyDataBaseService: injector(),
    ),
  );

  /// remote data source
  injector.registerFactory<HistoryDataSource>(
    () => HistoryDataSource(injector(), injector()),
  );

   /// repository
  injector.registerFactory<HistoryRepository>(
    () => HiustoryRepositoryImpl(
      injector(),
    ),
  );

  /// usecase
  injector.registerLazySingleton<HistoryUseCase>(() => HistoryUseCase(
        historyRepo: injector(),
      ));

  /// mapper
  injector.registerFactory<Function1<Response, HistoryDomainModel>>(
    () => HistoryDomainMapper(),
  );

  /// cubit
  injector.registerFactory<HistoryCubit>(() => HistoryCubit(injector()));
}
