// ignore_for_file: prefer_const_constructors

import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_view.dart';
import 'bloc/data_bloc/my_data_bloc.dart';

class MyApp extends StatelessWidget {
	final DataRepository dataRepository;
  const MyApp(this.dataRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MyDataBloc>(
          create: (_) => MyDataBloc(
            dataRepository: dataRepository,
          ),
        ),
      ],
      child: MyAppView(),
    );
  }
}