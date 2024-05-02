import 'package:equatable/equatable.dart';

class RoundModel extends Equatable {
  final String? name;
  final int? id;
  bool isSelect;

  RoundModel({this.name, this.id, this.isSelect = false});

  @override
  List<Object?> get props => [name, id, isSelect];
}
