import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../model/request/dashboard_request.dart';
import '../../model/request/product_list_request.dart';
import '../../model/response/dashboard_response.dart';
import '../../model/response/product_list_response.dart';
import 'retrofit_constants.dart';

part 'retrofit_manager.g.dart';

@RestApi(baseUrl: RetrofitConstants.baseApiUrl)
abstract class RetrofitManager {
  factory RetrofitManager(Dio dio, {String baseUrl}) = _RetrofitManager;

  @POST(RetrofitConstants.getProduct)
  Future<DashboardResponse> getDashboard(@Body() DashboardRequest params);

  @POST(RetrofitConstants.getProductList)
  Future<ProductListResponse> getProductList(@Body() ProductListRequest params);
}
