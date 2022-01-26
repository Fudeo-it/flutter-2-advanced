import 'package:bloc/bloc.dart';
import 'package:stato_globale/model/product_model.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartBlocEvent, ShoppingCartBlocState> {
  ShoppingCartBloc() : super(ShoppingCartBlocStateLoading()) {
    on<ShoppingCartBlocEventInit>((event, emit) async {
      emit(ShoppingCartBlocStateLoading());
      await Future.delayed(Duration(seconds: 2));
      emit(ShoppingCartBlocStateLoaded(products));
    });

    on<ShoppingCartBlocEventToggle>((event, emit) {
      final products = (state as ShoppingCartBlocStateLoaded).products;
      final product = products.firstWhere((it) => it.name == event.product.name);
      product.inShoppingCart = !product.inShoppingCart;

      emit(ShoppingCartBlocStateLoaded(products));
    });
  }
}

abstract class ShoppingCartBlocEvent {}

class ShoppingCartBlocEventInit extends ShoppingCartBlocEvent {}

class ShoppingCartBlocEventToggle extends ShoppingCartBlocEvent {
  final ProductModel product;
  ShoppingCartBlocEventToggle(this.product);
}

abstract class ShoppingCartBlocState {}

class ShoppingCartBlocStateLoading extends ShoppingCartBlocState {}

class ShoppingCartBlocStateLoaded extends ShoppingCartBlocState {
  final List<ProductModel> products;
  ShoppingCartBlocStateLoaded(this.products);
}
