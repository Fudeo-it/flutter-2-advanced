import 'package:app_bloc/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLoC"),
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterBlocState>(builder: (context, state) {
          final value = (state as CounterBlocStateValue).value;

          return TextButton(
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).add(
                CounterBlocEventDecrement(),
              );
            },
            child: Text(
              value.toString(),
              style: TextStyle(
                fontSize: 100,
              ),
            ),
          );
        }),
      ),
    );
  }
}
