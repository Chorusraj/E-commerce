import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/network/network_info.dart';
import 'package:e_commerce_app/features/products/data/datasources/product_datasource.dart';
import 'package:e_commerce_app/features/products/domain/entity/product_entity.dart';
import 'package:e_commerce_app/features/products/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDatasource datasource;
  final NetworkInfo networkInfo;
  ProductRepositoryImpl(this.datasource, this.networkInfo);

  @override
  Future<Either<Failure, List<ProductsEntity>>> fetchProducts() async {
    bool isConnected = await networkInfo.isConnected;
    if (!isConnected) return Left(NetworkFailure("No Internet connection"));
    try {
      final response = await datasource.getProducts();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure("$e"));
    }
  }
}
