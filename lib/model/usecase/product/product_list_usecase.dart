import 'package:dartz/dartz.dart';

import '../../../base/base_screen/base_use_case.dart';
import '../../../datasource/repository/product_repository/product_repository.dart';
import '../../../utils/error/failure.dart';
import '../../request/product_list_request.dart';
import '../../response/product_list_response.dart';

class ProductListUseCase extends UseCase<ProductListResponse, ProductListRequest> {
  final ProductRepository _repository;

  ProductListUseCase(this._repository);

  @override
  Future<Either<ProductListResponse, Failure>> call(ProductListRequest params) async {
    return await _repository.getProductList(params);
  }
}
