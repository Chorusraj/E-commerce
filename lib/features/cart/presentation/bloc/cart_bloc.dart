import 'package:e_commerce_app/features/cart/data/model/cart_item_model.dart';
import 'package:e_commerce_app/features/products/domain/entity/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import '../../domain/entity/cart_item_entity.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartItemEntity> _cartItems = [];

  final Box<CartItemModel> box = Hive.box<CartItemModel>('cartBox');

  CartBloc() : super(CartInitialState()) {
    _loadCart();

    on<AddToCartEvent>(_addToCart);
    on<RemoveFromCartEvent>(_removeFromCart);
    on<IncreaseQuantityEvent>(_increaseQuantity);
    on<DecreaseQuantityEvent>(_decreaseQuantity);
    on<ClearCartEvent>(_clearCart);
  }

  void _loadCart() {
    for (var item in box.values) {
      _cartItems.add(
        CartItemEntity(
          product: ProductsEntity(
            id: item.productId,
            title: item.title,
            price: item.price,
            image: item.image,
          ),
          quantity: item.quantity,
        ),
      );
    }
    emit(_updatedState());
  }

  void _addToCart(AddToCartEvent event, Emitter<CartState> emit) {
    final index = _cartItems.indexWhere(
      (item) => item.product.id == event.product.id,
    );

    if (index >= 0) {
      _cartItems[index] = _cartItems[index].copyWith(
        quantity: _cartItems[index].quantity + 1,
      );
    } else {
      _cartItems.add(CartItemEntity(product: event.product, quantity: 1));
    }

    _saveCart();
    emit(_updatedState());
  }

  void _removeFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    _cartItems.removeWhere((item) => item.product.id == event.product.id);

    _saveCart();
    emit(_updatedState());
  }

  void _increaseQuantity(IncreaseQuantityEvent event, Emitter<CartState> emit) {
    final index = _cartItems.indexWhere(
      (item) => item.product.id == event.product.id,
    );

    if (index >= 0) {
      _cartItems[index] = _cartItems[index].copyWith(
        quantity: _cartItems[index].quantity + 1,
      );

      _saveCart();
      emit(_updatedState());
    }
  }

  void _decreaseQuantity(DecreaseQuantityEvent event, Emitter<CartState> emit) {
    final index = _cartItems.indexWhere(
      (item) => item.product.id == event.product.id,
    );

    if (index >= 0) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index] = _cartItems[index].copyWith(
          quantity: _cartItems[index].quantity - 1,
        );
      } else {
        _cartItems.removeAt(index);
      }

      _saveCart();
      emit(_updatedState());
    }
  }

  void _clearCart(ClearCartEvent event, Emitter<CartState> emit) {
    _cartItems.clear();
    box.clear(); // clears Hive storage
    emit(_updatedState());
  }

  CartUpdatedState _updatedState() {
    final total = _cartItems.fold<double>(
      0,
      (sum, item) => sum + item.totalPrice,
    );

    return CartUpdatedState(items: List.from(_cartItems), totalAmount: total);
  }

  void _saveCart() {
    box.clear();
    for (var item in _cartItems) {
      box.add(
        CartItemModel(
          productId: item.product.id!,
          title: item.product.title ?? '',
          price: item.product.price ?? 0,
          image: item.product.image ?? '',
          quantity: item.quantity,
        ),
      );
    }
  }
}
