import '../../domain/entity/cart_item_entity.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartUpdatedState extends CartState {
  final List<CartItemEntity> items;
  final double totalAmount;

  CartUpdatedState({
    required this.items,
    required this.totalAmount,
  });

  int get totalItems =>
      items.fold(0, (sum, item) => sum + item.quantity);
}
