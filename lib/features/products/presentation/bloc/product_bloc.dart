import 'package:e_commerce_app/core/usecase/usecase.dart';
import 'package:e_commerce_app/features/products/domain/usecase/fetch_product_usecase.dart';
import 'package:e_commerce_app/features/products/presentation/bloc/product_event.dart';
import 'package:e_commerce_app/features/products/presentation/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductBloc  extends Bloc<ProductEvent, ProductState> {
  final FetchProductUsecase fetchProductUsecase;
  ProductBloc(this.fetchProductUsecase) : super(const ProductInitialState()) {
   on<FetchProductsEvent>(_onFetchProductEvent);
  }
  void _onFetchProductEvent(
    FetchProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    final result= await fetchProductUsecase.call(NoParams());
    result.fold((f) {
      emit(ProductErrorState(f.message));
    }, (p) {
      emit(ProductLoadedState(p));
    });
    try {
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }
}