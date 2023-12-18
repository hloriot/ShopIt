import 'package:equatable/equatable.dart';
import 'package:shop_it/domain/model/city.dart';
import 'package:shop_it/domain/model/shop.dart';

sealed class ShopListState extends Equatable {

  @override
  List<Object?> get props => List.empty();
}

class ShopListStateInitial extends ShopListState {

  @override
  List<Object?> get props => List.empty();
}

class ShopListStateList extends ShopListState {
  final List<Shop> shops;
  final List<City> suggestions;

  ShopListStateList({required this.shops, required this.suggestions});

  @override
  List<Object?> get props => [shops, suggestions];
}

class ShopListStateFinished extends ShopListState {

  @override
  List<Object?> get props => List.empty();
}

