import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_it/domain/model/permission.dart';
import 'package:shop_it/domain/manager/permission_manager.dart';
import 'package:shop_it/presentation/splash_screen/splash_screen_event.dart';
import 'package:shop_it/presentation/splash_screen/splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final PermissionManager _permissionManager;

  SplashScreenBloc({
    required PermissionManager permissionManager,
  })  : _permissionManager = permissionManager,
        super(SplashScreenStateInitial()) {
    on<SplashScreenStarted>(_onStart);
  }

  Future<void> _onStart(
    SplashScreenStarted event,
    Emitter<SplashScreenState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    if (await _permissionManager.isPermissionGranted(Permission.location)) {
      emit(SplashScreenStateFinished());
      return;
    }

    await _permissionManager.requestPermission(Permission.location);

    if (await _permissionManager.isPermissionGranted(Permission.location)) {
      emit(SplashScreenStateFinished());
    } else {
      // We can also display an error at the bottom of the page
      emit(SplashScreenStateFinished());
    }
  }
}
