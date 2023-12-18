import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_it/presentation/shop_list/shop_list_page.dart';
import 'package:shop_it/presentation/splash_screen/splash_screen_bloc.dart';
import 'package:shop_it/presentation/splash_screen/splash_screen_state.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashScreenBloc, SplashScreenState>(
      listenWhen: (previousState, state) => previousState != state,
      listener: (context, state) {
        switch (state.runtimeType) {
          case SplashScreenStateFinished:
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ShopListPage(),
              ),
            );
        }
      },
      child: const Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [Spacer()],
            ),
            Spacer(),
            Text("Shop it"),
            Spacer(),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
