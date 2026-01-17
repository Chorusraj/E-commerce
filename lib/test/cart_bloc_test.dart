// test/cart_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:e_commerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce_app/features/cart/presentation/bloc/cart_event.dart';
import 'package:e_commerce_app/features/cart/presentation/bloc/cart_state.dart';
import 'package:e_commerce_app/features/cart/domain/entity/cart_item_entity.dart';
import 'package:e_commerce_app/features/products/domain/entity/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CartBloc cartBloc;
  late ProductsEntity product;

  setUp(() {
    cartBloc = CartBloc();
    product = ProductsEntity(
      id: 1,
      title: 'Test Product',
      price: 10.0,
      description: 'This is a test product',
      category: 'Test',
      image: 'https://via.placeholder.com/150',
    );
  });

  tearDown(() {
    cartBloc.close();
  });

  test('initial state should be CartInitialState', () {
    expect(cartBloc.state, isA<CartInitialState>());
  });

  blocTest<CartBloc, CartState>(
    'adds item to cart on AddToCartEvent',
    build: () => cartBloc,
    act: (bloc) => bloc.add(AddToCartEvent(product)),
    expect: () => [
      isA<CartUpdatedState>()
          .having((state) => state.items.length, 'items length', 1)
          .having((state) => state.totalAmount, 'total', 10.0),
    ],
  );

  blocTest<CartBloc, CartState>(
    'increments quantity if same product is added again',
    build: () => cartBloc,
    act: (bloc) {
      bloc.add(AddToCartEvent(product));
      bloc.add(AddToCartEvent(product));
    },
    expect: () => [
      isA<CartUpdatedState>().having((s) => s.items.first.quantity, 'quantity', 1),
      isA<CartUpdatedState>().having((s) => s.items.first.quantity, 'quantity', 2),
    ],
  );

  blocTest<CartBloc, CartState>(
    'removes product on RemoveFromCartEvent',
    build: () => cartBloc,
    act: (bloc) {
      bloc.add(AddToCartEvent(product));
      bloc.add(RemoveFromCartEvent(product));
    },
    expect: () => [
      isA<CartUpdatedState>().having((s) => s.items.length, 'items length', 1),
      isA<CartUpdatedState>().having((s) => s.items.length, 'items length', 0),
    ],
  );

  blocTest<CartBloc, CartState>(
    'decreases quantity or removes item on DecreaseQuantityEvent',
    build: () => cartBloc,
    act: (bloc) {
      bloc.add(AddToCartEvent(product)); // quantity 1
      bloc.add(AddToCartEvent(product)); // quantity 2
      bloc.add(DecreaseQuantityEvent(product)); // quantity 1
      bloc.add(DecreaseQuantityEvent(product)); // quantity removed
    },
    expect: () => [
      isA<CartUpdatedState>().having((s) => s.items.first.quantity, 'quantity', 1),
      isA<CartUpdatedState>().having((s) => s.items.first.quantity, 'quantity', 2),
      isA<CartUpdatedState>().having((s) => s.items.first.quantity, 'quantity', 1),
      isA<CartUpdatedState>().having((s) => s.items.length, 'items length', 0),
    ],
  );

  blocTest<CartBloc, CartState>(
    'clears cart on ClearCartEvent',
    build: () => cartBloc,
    act: (bloc) {
      bloc.add(AddToCartEvent(product));
      bloc.add(ClearCartEvent());
    },
    expect: () => [
      isA<CartUpdatedState>().having((s) => s.items.length, 'items length', 1),
      isA<CartUpdatedState>().having((s) => s.items.length, 'items length', 0),
    ],
  );
}
