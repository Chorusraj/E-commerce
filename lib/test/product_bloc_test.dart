// test/product_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/usecase/usecase.dart';
import 'package:e_commerce_app/features/products/domain/entity/product_entity.dart';
import 'package:e_commerce_app/features/products/domain/usecase/fetch_product_usecase.dart';
import 'package:e_commerce_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:e_commerce_app/features/products/presentation/bloc/product_event.dart';
import 'package:e_commerce_app/features/products/presentation/bloc/product_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock class
class MockFetchProductUsecase extends Mock implements FetchProductUsecase {}

void main() {
  late ProductBloc productBloc;
  late MockFetchProductUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockFetchProductUsecase();
    productBloc = ProductBloc(mockUsecase);
  });

  tearDown(() {
    productBloc.close();
  });

  // Sample product list for testing
  final productList = [
    ProductsEntity(
      id: 1,
      title: 'Test Product 1',
      price: 10.0,
      description: 'Test Description',
      category: 'Test',
      image: 'https://via.placeholder.com/150',
    ),
    ProductsEntity(
      id: 2,
      title: 'Test Product 2',
      price: 20.0,
      description: 'Test Description 2',
      category: 'Test',
      image: 'https://via.placeholder.com/150',
    ),
  ];

  test('initial state should be ProductInitialState', () {
    expect(productBloc.state, const ProductInitialState());
  });

  blocTest<ProductBloc, ProductState>(
    'emits [ProductLoadingState, ProductLoadedState] when fetch is successful',
    build: () {
      when(() => mockUsecase.call(NoParams()))
          .thenAnswer((_) async => Right(productList));
      return productBloc;
    },
    act: (bloc) => bloc.add(FetchProductsEvent()),
    expect: () => [
      ProductLoadingState(),
      ProductLoadedState(productList),
    ],
    verify: (_) {
      verify(() => mockUsecase.call(NoParams())).called(1);
    },
  );

  blocTest<ProductBloc, ProductState>(
    'emits [ProductLoadingState, ProductErrorState] when fetch fails',
    build: () {
      when(() => mockUsecase.call(NoParams()))
          .thenAnswer((_) async => Left(Exception('Failed to fetch products') as Failure));
      return productBloc;
    },
    act: (bloc) => bloc.add(FetchProductsEvent()),
    expect: () => [
      ProductLoadingState(),
      ProductErrorState('Exception: Failed to fetch products'),
    ],
    verify: (_) {
      verify(() => mockUsecase.call(NoParams())).called(1);
    },
  );
}
