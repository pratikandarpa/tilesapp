import 'package:dartz/dartz.dart';

import '../../../model/request/dashboard_request.dart';
import '../../../model/request/product_list_request.dart';
import '../../../model/response/dashboard_response.dart';
import '../../../model/response/product_list_response.dart';
import '../../../utils/error/failure.dart';

abstract class ProductRepository {
  Future<Either<DashboardResponse, Failure>> getDashboard(DashboardRequest params);
  Future<Either<ProductListResponse, Failure>> getProductList(ProductListRequest params);
}
