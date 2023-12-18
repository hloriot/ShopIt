import 'package:shop_it/domain/model/city.dart';
import 'package:shop_it/domain/model/day.dart';
import 'package:shop_it/domain/model/opening_hours.dart';
import 'package:shop_it/domain/model/shop.dart';
import 'package:shop_it/domain/repository/shop_repository.dart';

class ShopRepositoryImpl extends ShopRepository {
  @override
  Future<List<Shop>> getShops({City? city}) {
    return Future.value([
      const Shop(
        name: "Magasin 1",
        phoneNumber: "03 01 02 03 04",
        address: "87 rue du Fontenoy, 59100 Roubaix",
        openingHours: [
          OpeningHours(day: Day.monday, hours: "09h00-18h00"),
          OpeningHours(day: Day.tuesday, hours: "09h00-18h00"),
          OpeningHours(day: Day.wednesday, hours: "09h00-18h00"),
          OpeningHours(day: Day.thursday, hours: "09h00-18h00"),
          OpeningHours(day: Day.friday, hours: "09h00-18h00"),
          OpeningHours(day: Day.saturday, hours: "09h00-18h00"),
          OpeningHours(day: Day.sunday, hours: "Fermé"),
        ],
      ),
      const Shop(
        name: "Magasin 2",
        phoneNumber: "03 01 02 03 04",
        address: "66 rue de Nancy, 59100 Roubaix",
        openingHours: [
          OpeningHours(day: Day.monday, hours: "09h00-18h00"),
          OpeningHours(day: Day.tuesday, hours: "09h00-18h00"),
          OpeningHours(day: Day.wednesday, hours: "09h00-18h00"),
          OpeningHours(day: Day.thursday, hours: "09h00-18h00"),
          OpeningHours(day: Day.friday, hours: "09h00-18h00"),
          OpeningHours(day: Day.saturday, hours: "09h00-18h00"),
          OpeningHours(day: Day.sunday, hours: "Fermé"),
        ],
      ),
    ]);
  }
}
