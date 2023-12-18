import 'package:equatable/equatable.dart';
import 'package:shop_it/domain/model/opening_hours.dart';

class Shop extends Equatable {
  final String name;
  final String? phoneNumber;
  final String address;
  final List<OpeningHours> openingHours;

  const Shop({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.openingHours,
  });

  @override
  List<Object?> get props => [name, phoneNumber, address, openingHours];
}
