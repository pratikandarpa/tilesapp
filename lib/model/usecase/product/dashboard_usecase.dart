import 'package:dartz/dartz.dart';

import '../../../base/base_screen/base_use_case.dart';
import '../../../datasource/repository/product_repository/product_repository.dart';
import '../../../utils/error/failure.dart';
import '../../request/dashboard_request.dart';
import '../../response/dashboard_response.dart';

class DashboardUseCase extends UseCase<DashboardResponse, DashboardRequest> {
  final ProductRepository _productRepository;

  DashboardUseCase(this._productRepository);

  @override
  Future<Either<DashboardResponse, Failure>> call(DashboardRequest params) async {
    return await _productRepository.getDashboard(params);
  }
}
