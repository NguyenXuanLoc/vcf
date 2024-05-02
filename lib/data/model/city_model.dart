import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  final String? name;
  final int? id;
  bool isSelect;

  CityModel({this.name, this.id, this.isSelect = false});

  @override
  List<Object?> get props => [name, id, isSelect];
}
