import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_it/data/keys/ApiKeys.dart';
import 'package:shop_it/domain/model/city.dart';
import 'package:shop_it/domain/repository/city_repository.dart';

class GoogleAutoCompleteCityRepository extends CityRepository {
  @override
  Future<List<City>> getCities({String? query}) async {
    if (query == null) {
      return Future.value(List.empty());
    }

    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
        'input=$query&'
        'types=(regions)&'
        'key=$googleApiKey',
      ),
    );

    if (response.statusCode == 200) {
      return _jsonToCities(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load cities');
    }
  }

  List<City> _jsonToCities(Map<String, dynamic> json) {
    return switch (json) {
      {
      'status': String status,
      'predictions': List<dynamic> result,
      } =>
          result.map((city) => _jsonToCity(city)).toList(),
      _ => throw const FormatException('Failed to load cities.'),
    };
  }

  City _jsonToCity(Map<String, dynamic> json) {
    return switch (json) {
      {
      'description': String name,
      } =>
          City(
            name: name,
            zipcode: "00000", // Not provided by the API
            latitude: 0.0, // Not provided by the API
            longitude: 0.0 // Not provided by the API
          ),
      _ => throw const FormatException('Failed to load city.'),
    };
  }

}
