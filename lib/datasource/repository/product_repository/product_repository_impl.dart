import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tilesapp/datasource/repository/product_repository/product_repository.dart';
import 'package:tilesapp/model/request/dashboard_request.dart';
import 'package:tilesapp/model/request/product_list_request.dart';
import 'package:tilesapp/model/response/dashboard_response.dart';
import 'package:tilesapp/model/response/product_list_response.dart';
import 'package:tilesapp/utils/error/failure.dart';

import '../../../utils/network/network_info.dart';
import '../../remote/retrofit_manager.dart';

class ProductRepositoryImpl extends ProductRepository {
  final NetworkInfo _networkInfo;
  final RetrofitManager _retrofit;

  ProductRepositoryImpl(this._networkInfo, this._retrofit);

  @override
  Future<Either<DashboardResponse, Failure>> getDashboard(DashboardRequest params) async {
    if (await _networkInfo.isConnected()) {
      try {
        final response = await _retrofit.getDashboard(params);
        if (response.status == 200) {
          return Left(response);
        }
        return Right(Failure(message: response.message));
      } on DioException catch (exception) {
        if (exception.response?.statusCode == 503) {
          return Right(Failure(message: exception.response?.statusMessage));
        }
        return Right(Failure(message: exception.response?.data["message"]));
      } catch (error) {
        return const Right(Failure(message: FailureMessage.server));
      }
    } else {
      return const Right(Failure(message: FailureMessage.internet, status: FailureStatus.internet));
    }
  }

  @override
  Future<Either<ProductListResponse, Failure>> getProductList(ProductListRequest params) async {
    if (await _networkInfo.isConnected()) {
      try {
        final response = await _retrofit.getProductList(params);
        if (response.status == 200) {
          return Left(response);
        }
        return Right(Failure(message: response.message));
      } on DioException catch (exception) {
        if (exception.response?.statusCode == 503) {
          return Right(Failure(message: exception.response?.statusMessage));
        }
        return Right(Failure(message: exception.response?.data["message"]));
      } catch (error) {
        return const Right(Failure(message: FailureMessage.server));
      }
    } else {
      return const Right(Failure(message: FailureMessage.internet, status: FailureStatus.internet));
    }
  }
}
