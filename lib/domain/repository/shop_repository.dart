import 'package:shop_it/domain/model/city.dart';
import 'package:shop_it/domain/model/shop.dart';

abstract class ShopRepository {
  Future<List<Shop>> getShops({City? city});
}