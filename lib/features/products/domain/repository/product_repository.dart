import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/products/domain/entity/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure,List<ProductsEntity>>> fetchProducts();
}