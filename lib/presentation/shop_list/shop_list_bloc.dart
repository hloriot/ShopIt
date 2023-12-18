import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_it/domain/manager/permission_manager.dart';
import 'package:shop_it/domain/repository/city_repository.dart';
import 'package:shop_it/domain/repository/shop_repository.dart';
import 'package:shop_it/presentation/shop_list/shop_list_event.dart';
import 'package:shop_it/presentation/shop_list/shop_list_state.dart';

class ShopListBloc extends Bloc<ShopListEvent, ShopListState> {
  final PermissionManager _permissionManager;
  final CityRepository _cityRepository;
  final ShopRepository _shopRepository;

  ShopListBloc({
    required PermissionManager permissionManager,
    required CityRepository cityRepository,
    required ShopRepository shopRepository,
  })  : _permissionManager = permissionManager,
        _cityRepository = cityRepository,
        _shopRepository = shopRepository,
        super(ShopListStateInitial()) {
    on<ShopListStarted>(_onStart);
    on<ShopListOnQueryChanged>(_onQueryChanged);
  }

  Future<void> _onStart(
    ShopListStarted event,
    Emitter<ShopListState> emit,
  ) async {
    final cities = await _cityRepository.getCities();
    final shops = await _shopRepository.getShops();
    emit(ShopListStateList(shops: shops, suggestions: cities));
  }

  Future<void> _onQueryChanged(
    ShopListOnQueryChanged event,
    Emitter<ShopListState> emit,
  ) async {
    final cities = await _cityRepository.getCities(query: event.query);
    // To prevent API spam, getShops can be call on query submitted instead of
    // on query changed
    final shops = await _shopRepository.getShops(city: cities.firstOrNull);
    emit(ShopListStateList(shops: shops, suggestions: cities));
  }
}
