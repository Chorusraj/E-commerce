import 'package:e_commerce_app/features/products/domain/entity/product_entity.dart';

abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final ProductsEntity product;
  AddToCartEvent(this.product);
}

class RemoveFromCartEvent extends CartEvent {
  final ProductsEntity product;
  RemoveFromCartEvent(this.product);
}

class IncreaseQuantityEvent extends CartEvent {
  final ProductsEntity product;
  IncreaseQuantityEvent(this.product);
}

class DecreaseQuantityEvent extends CartEvent {
  final ProductsEntity product;
  DecreaseQuantityEvent(this.product);
}

class ClearCartEvent extends CartEvent {}
