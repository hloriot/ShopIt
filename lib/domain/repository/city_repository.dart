import 'package:shop_it/domain/model/city.dart';

abstract class CityRepository {
  Future<List<City>> getCities({String? query});
}