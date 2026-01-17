import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/network/api_client.dart';
import 'package:e_commerce_app/core/network/network_info.dart';
import 'package:e_commerce_app/core/storage/secure_storage.dart';
import 'package:e_commerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce_app/features/products/data/datasources/product_datasource.dart';
import 'package:e_commerce_app/features/products/data/datasources/product_datasource_impl.dart';
import 'package:e_commerce_app/features/products/domain/repository/product_repository.dart';
import 'package:e_commerce_app/features/products/domain/repository/product_repository_impl.dart';
import 'package:e_commerce_app/features/products/domain/usecase/fetch_product_usecase.dart';
import 'package:e_commerce_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Future<void> registerDependencies() async {
  //registering external packages
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  //core services
  sl.registerLazySingleton<SecurePref>(
    () => SecurePref(storage: sl<FlutterSecureStorage>()),
  );
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(dio: sl<Dio>(), securePref: sl<SecurePref>()),
  );
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  //data sources
  sl.registerLazySingleton<ProductDatasource>(() => ProductDatasourceImpl(sl<ApiClient>()));
  //other data sources can be registered here

  //repositories
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(sl<ProductDatasource>(), sl<NetworkInfo>()));
  //other repositories can be registered here

  //usecase
  sl.registerLazySingleton<FetchProductUsecase>(() => FetchProductUsecase(sl<ProductRepository>()));
  //other usecase can be registered here

  //blocs
  sl.registerFactory<ProductBloc>(() => ProductBloc(sl<FetchProductUsecase>()));
  sl.registerFactory<CartBloc>(()=> CartBloc());
}
