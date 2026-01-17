
import 'package:e_commerce_app/features/products/data/model/product_model.dart';

abstract class ProductDatasource {
  Future<List<ProductModel>>getProducts();
}