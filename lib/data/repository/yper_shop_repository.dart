import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shop_it/data/keys/ApiKeys.dart';
import 'package:shop_it/domain/model/city.dart';
import 'package:shop_it/domain/model/day.dart';
import 'package:shop_it/domain/model/opening_hours.dart';
import 'package:shop_it/domain/model/shop.dart';
import 'package:shop_it/domain/repository/shop_repository.dart';

class YperShopRepository extends ShopRepository {
  @override
  Future<List<Shop>> getShops({City? city}) async {
    final String coordinates;
    if (city != null) {
      coordinates = "${city.latitude},${city.longitude}";
    } else {
      coordinates = "0.0,0.0";
    }

    final response = await http.get(
      Uri.parse(
        'https://io.beta.yper.org/retailpoint/search?'
        'location=$coordinates&'
        'min_distance=0&'
        'max_distance=${0x7FFFFFFFFFFFFFFF}&'
        'limit=10',
      ),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $yperApiKey',
        "X-Request-Timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      },
    );

    if (response.statusCode == 200) {
      return _jsonToShops(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load shops.');
    }
  }

  List<Shop> _jsonToShops(Map<String, dynamic> json) {
    return switch (json) {
      {
        'status': int status,
        'result': List<dynamic> result,
      } =>
        result.map((shop) => _jsonToShop(shop)).toList(),
      _ => throw const FormatException('Failed to load shops.'),
    };
  }

  Shop _jsonToShop(Map<String, dynamic> json) {
    return switch (json) {
      {
        'name': String name,
        'address': Map<String, dynamic> address,
        'phone': Map<String, dynamic> phone,
        // We are using delivery_hours instead of opening_hours, because it contains hours for each day
        // Also opening_hours sometimes is empty, contains only "0" and doesn't have a proper format
        'delivery_hours': List<dynamic> openingHours,
      } =>
        Shop(
          name: name,
          phoneNumber: _jsonToPhone(phone),
          address: _jsonToAddress(address),
          openingHours: _jsonToOpeningHours(openingHours),
        ),
      _ => throw const FormatException('Failed to load shop.'),
    };
  }

  String? _jsonToPhone(Map<String, dynamic> json) {
    return switch (json) {
      {
        'public': String? phone,
      } =>
        phone,
      _ => throw const FormatException('Failed to load phone.'),
    };
  }

  String _jsonToAddress(Map<String, dynamic> json) {
    return switch (json) {
      {
        'formatted_address': String address,
      } =>
        address,
      _ => throw const FormatException('Failed to load address.'),
    };
  }

  List<OpeningHours> _jsonToOpeningHours(List<dynamic> json) {
    return json.map((openingHours) {
      return switch (openingHours) {
        {
          'day': int day,
          'hours': Map<String, dynamic> hours,
        } =>
          OpeningHours(
            day: _intDayToDay(day),
            hours: _jsonToOpeningHoursStartEnd(hours),
          ),
        _ => throw const FormatException('Failed to load openingHours.'),
      };
    }).toList();
  }

  String _jsonToOpeningHoursStartEnd(Map<String, dynamic> json) {
    final dateFormat = DateFormat("HH:mm");

    return switch (json) {
      {
        'start': String start,
        'end': String end,
      } =>
        "${dateFormat.format(DateTime.parse(start))}-${dateFormat.format(DateTime.parse(end))}",
      _ => throw const FormatException('Failed to load openingHours.'),
    };
  }

  Day _intDayToDay(int day) {
    switch (day) {
      case 1:
        return Day.monday;
      case 2:
        return Day.tuesday;
      case 3:
        return Day.wednesday;
      case 4:
        return Day.thursday;
      case 5:
        return Day.friday;
      case 6:
        return Day.saturday;
      case 7:
        return Day.sunday;
      default:
        throw const FormatException('Invalid day.');
    }
  }
}
