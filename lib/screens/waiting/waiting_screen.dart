// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			body: Center(
				child: LoadingAnimationWidget.newtonCradle(
        color: Theme.of(context).colorScheme.primary,
        size: 200,
      ),
			),
		);
  }
}