import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseState<T extends StatefulWidget, X extends Cubit>
    extends BaseSetState<T> {
  late X bloc;

  void init();

  X createCubit();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    bloc = createCubit();
    super.initState();
    init();
  }
}

abstract class BaseSetState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(fn) {
    if (!mounted) {
      return;
    }
    super.setState(fn);
  }
}
