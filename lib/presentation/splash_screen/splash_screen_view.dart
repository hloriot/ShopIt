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
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  "shop it",
                  style: TextStyle(
                    fontSize: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const Spacer(),
                const CircularProgressIndicator(strokeWidth: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
