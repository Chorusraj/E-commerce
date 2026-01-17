import 'package:e_commerce_app/features/products/domain/entity/product_entity.dart';

class CartItemEntity {
  final ProductsEntity product;
  final int quantity;

  CartItemEntity({
    required this.product,
    required this.quantity,
  });

  CartItemEntity copyWith({int? quantity}) {
    return CartItemEntity(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice =>
      (product.price ?? 0) * quantity;
}
