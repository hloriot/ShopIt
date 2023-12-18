import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_it/domain/manager/permission_manager.dart';
import 'package:shop_it/presentation/splash_screen/splash_screen_bloc.dart';
import 'package:shop_it/presentation/splash_screen/splash_screen_event.dart';
import 'package:shop_it/presentation/splash_screen/splash_screen_view.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashScreenBloc(
        permissionManager: context.read<PermissionManager>(),
      )..add(SplashScreenStarted()),
      child: const SplashScreenView(),
    );
  }
}
