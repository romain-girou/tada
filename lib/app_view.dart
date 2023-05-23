// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tada/bloc/data_bloc/my_data_bloc.dart';
import 'package:tada/screens/home/home_screen.dart';
import 'screens/waiting/waiting_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Walkome',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
					background: Colors.white,
					onBackground: Colors.black,
					primary: Color(0xFF6236FF),
					onPrimary: Colors.white,
				),
      ),
      home: BlocBuilder<MyDataBloc, MyDataState>(
        builder: (context, state) {
          if (state.status == MyDataStatus.success) {
            return HomeScreen();
          } else {
            return WaitingScreen();
          }
        },
      ),
    );
  }
}
