import 'package:app_bloc/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLoC"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/second");
            },
            icon: Icon(Icons.arrow_right_alt),
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterBlocState>(builder: (context, state) {
          return TextButton(
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).add(
                CounterBlocEventIncrement(),
              );
            },
            child: Text(
              (state as CounterBlocStateValue).value.toString(),
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
