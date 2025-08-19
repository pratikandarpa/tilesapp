import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tilesapp/datasource/repository/product_repository/product_repository.dart';
import 'package:tilesapp/model/usecase/product/dashboard_usecase.dart';
import 'package:tilesapp/model/usecase/product/product_list_usecase.dart';
import 'package:tilesapp/ui/home/home_controller.dart';
import 'package:tilesapp/ui/strip/strip_controller.dart';
import 'package:tilesapp/utils/network/network_info.dart';

import 'datasource/remote/retrofit_manager.dart';
import 'datasource/repository/product_repository/product_repository_impl.dart';

final di = GetIt.instance;

Future<void> init() async {
  // Controller
  di.registerLazySingleton<HomeController>(() => HomeController(di(), di()));
  di.registerLazySingleton<StripController>(() => StripController());

  // Use Cases
  di.registerLazySingleton<DashboardUseCase>(() => DashboardUseCase(di()));
  di.registerLazySingleton<ProductListUseCase>(() => ProductListUseCase(di()));

  // Repository
  di.registerLazySingleton<ProductRepository>(() {
    return ProductRepositoryImpl(di(), di());
  });

  // Network Manager
  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // Remote Manager
  di.registerLazySingleton(() => RetrofitManager(di()));

  // Dio
  di.registerLazySingleton<Dio>(() {
    final dio = Dio();
    /*dio.interceptors.add(
      PrettyDioLogger(requestHeader: true, requestBody: true),
    );*/
    return dio;
  });
}
