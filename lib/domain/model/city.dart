import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String name;
  final String zipcode;
  final double latitude;
  final double longitude;

  const City({
    required this.name,
    required this.zipcode,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [name, zipcode, latitude, longitude];
}
