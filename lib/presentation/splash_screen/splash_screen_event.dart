import 'package:equatable/equatable.dart';

sealed class SplashScreenEvent extends Equatable {
  @override
  List<Object?> get props => List.empty();
}

class SplashScreenStarted extends SplashScreenEvent {
  @override
  List<Object?> get props => List.empty();
}