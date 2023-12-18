import 'package:equatable/equatable.dart';
import 'package:shop_it/domain/model/permission.dart';

sealed class SplashScreenState extends Equatable {

  @override
  List<Object?> get props => List.empty();
}

class SplashScreenStateInitial extends SplashScreenState {

  @override
  List<Object?> get props => List.empty();
}

class SplashScreenStatePermissionRequired extends SplashScreenState {
  final Permission permission;

  SplashScreenStatePermissionRequired({required this.permission});

  @override
  List<Object?> get props => [permission];
}

class SplashScreenStateFinished extends SplashScreenState {

  @override
  List<Object?> get props => List.empty();
}

