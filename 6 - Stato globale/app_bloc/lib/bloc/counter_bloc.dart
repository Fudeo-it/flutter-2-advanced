import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterBlocEvent, CounterBlocState> {
  CounterBloc() : super(CounterBlocStateValue(5)) {
    on<CounterBlocEventIncrement>((event, emit) {
      final currentState = (state as CounterBlocStateValue).value;
      final newState = currentState + 1;
      emit(CounterBlocStateValue(newState));
    });

    on<CounterBlocEventDecrement>((event, emit) {
      final currentState = (state as CounterBlocStateValue).value;
      final newState = currentState - 1;
      emit(CounterBlocStateValue(newState));
    });
  }
}

// ------------

abstract class CounterBlocEvent {}

class CounterBlocEventIncrement extends CounterBlocEvent {}

class CounterBlocEventDecrement extends CounterBlocEvent {}

// ------------

abstract class CounterBlocState {}

class CounterBlocStateValue extends CounterBlocState {
  final int value;
  CounterBlocStateValue(this.value);
}
