import 'package:equatable/equatable.dart';

sealed class ShopListEvent extends Equatable {
  @override
  List<Object?> get props => List.empty();
}

class ShopListStarted extends ShopListEvent {
  @override
  List<Object?> get props => List.empty();
}

class ShopListOnQueryChanged extends ShopListEvent {
  final String query;

  ShopListOnQueryChanged({required this.query});

  @override
  List<Object?> get props => [query];
}