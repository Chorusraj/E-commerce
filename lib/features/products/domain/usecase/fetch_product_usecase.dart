import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/usecase/usecase.dart';
import 'package:e_commerce_app/features/products/domain/entity/product_entity.dart';
import 'package:e_commerce_app/features/products/domain/repository/product_repository.dart';

class FetchProductUsecase extends UseCase<List<ProductsEntity>,NoParams>{
  final ProductRepository repository;
  FetchProductUsecase(this.repository);

  @override
  Future<Either<Failure, List<ProductsEntity>>> call(NoParams params) async {
   return await repository.fetchProducts();
  }
  
}