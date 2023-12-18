import 'package:shop_it/domain/model/city.dart';
import 'package:shop_it/domain/repository/city_repository.dart';

class CityRepositoryImpl extends CityRepository {
  @override
  Future<List<City>> getCities({String? query}) {
    return Future.value([
      const City(
        name: "Tourcoing",
        zipcode: "59200",
        latitude: 50.7235038,
        longitude: 3.1605714
      ),
      const City(
        name: "Lille",
        zipcode: "59260",
          latitude: 50.6365654,
          longitude: 3.0635282
      ),
      const City(
        name: "Roncq",
        zipcode: "59223",
          latitude: 50.7531232,
          longitude: 3.1209016
      ),
      const City(
        name: "Meteren",
        zipcode: "59270",
          latitude: 50.7409084,
          longitude: 2.6911739
      ),
      const City(
        name: "Dunkerque",
        zipcode: "59240",
          latitude: 51.0347708,
          longitude: 2.3772525
      ),
      const City(
          name: "Coignières",
          zipcode: "78310",
          latitude: 48.7511787,
          longitude: 1.9201632
      ),
    ]);
  }
}
