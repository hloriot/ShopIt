import 'package:equatable/equatable.dart';
import 'package:shop_it/domain/model/day.dart';

class OpeningHours extends Equatable {
  final Day day;
  final String hours;

  const OpeningHours({
    required this.day,
    required this.hours,
  });

  @override
  List<Object?> get props => [day, hours];
}
