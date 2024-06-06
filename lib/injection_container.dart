import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:i_billing/features/core/platform/network_info.dart';
import 'package:i_billing/features/ibilling/data/datasources/ibilling_remote_data_sources.dart';
import 'package:i_billing/features/ibilling/data/repository/ibilling_repository_impl.dart';
import 'package:i_billing/features/ibilling/domain/usecases/create_contract_use_case.dart';
import 'package:i_billing/features/ibilling/domain/usecases/get_list_of_contacts_use_case.dart';
import 'package:i_billing/features/ibilling/domain/usecases/get_user_info_use_case.dart';
import 'package:i_billing/features/ibilling/presentation/bloc/connection_bloc/connection_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/bloc/ibilling_bloc/ibilling_bloc.dart';

import 'features/ibilling/domain/repository/ibilling_repository.dart';

final sl = GetIt.instance;

void init() {
  // Ensure that Connectivity is registered before NetworkInfoImp
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  sl.registerLazySingleton<NetworkHelper>(() => NetworkHelper());

  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  sl.registerLazySingleton(() async => await Firebase.initializeApp());

  sl.registerLazySingleton<IbillingRemoteDataSources>(
      () => IbillingRemoteDataSourcesImpl(
            firebaseFirestore: sl(),
          ));

  sl.registerLazySingleton<IBillingRepository>(() => IBillingRepositoryImpl(
        ibillingRemoteDataSources: sl(),
      ));

  sl.registerLazySingleton<GetListOfContactsUseCase>(
      () => GetListOfContactsUseCase(repository: sl()));

  sl.registerLazySingleton<CreateContractUseCase>(
      () => CreateContractUseCase(repository: sl()));

  sl.registerLazySingleton<CreateContract>(() => CreateContract(sl()));

  sl.registerLazySingleton<GetUserInfoUseCase>(
      () => GetUserInfoUseCase(repository: sl()));

  sl.registerFactory(() => NetworkBloc());

  sl.registerFactory(() => IbillingBloc(
      getListOfContractsUseCase: sl(),
      networkBloc: sl(),
      getUserInfoUseCase: sl(),
      createContractUseCase: sl()));

  sl.registerLazySingleton<GetUserInfo>(() => GetUserInfo(sl()));

  // The list registration might not be necessary depending on its use
  sl.registerLazySingleton<List<ConnectivityResult>>(() => []);
}
