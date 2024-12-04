import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'cost.dart';

class Costs extends Equatable {
  final String? code;
  final String? name;
  final List<Cost>? costs;

  const Costs({this.code, this.name, this.costs});

  factory Costs.fromMap(Map<String, dynamic> data) => Costs(
        code: data['code'] as String?,
        name: data['name'] as String?,
        costs: (data['costs'] as List<dynamic>?)
            ?.map((e) => Cost.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'code': code,
        'name': name,
        'costs': costs?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Costs].
  factory Costs.fromJson(String data) {
    return Costs.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Costs] to a JSON string.
  String toJson() => json.encode(toMap());

  Costs copyWith({
    String? code,
    String? name,
    List<Cost>? costs,
  }) {
    return Costs(
      code: code ?? this.code,
      name: name ?? this.name,
      costs: costs ?? this.costs,
    );
  }

  @override
  List<Object?> get props => [code, name, costs];
}
