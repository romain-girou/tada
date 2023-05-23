import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tada/simple_bloc_observer.dart';
import 'app.dart';


Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp(DataRepositoryOperations(dio: Dio())));
}