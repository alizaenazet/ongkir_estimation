import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:learn_mvc/model/costs/cost_detail.dart';

class Cost extends Equatable {
  final String? service;
  final String? description;
  final List<CostDetail>? cost;

  const Cost({this.service, this.description, this.cost});

  factory Cost.fromMap(Map<String, dynamic> data) => Cost(
        service: data['service'] as String?,
        description: data['description'] as String?,
        cost: (data['cost'] as List<dynamic>?)
            ?.map((e) => CostDetail.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'service': service,
        'description': description,
        'cost': cost?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Cost].
  factory Cost.fromJson(String data) {
    return Cost.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Cost] to a JSON string.
  String toJson() => json.encode(toMap());

  Cost copyWith({
    String? service,
    String? description,
    List<CostDetail>? cost,
  }) {
    return Cost(
      service: service ?? this.service,
      description: description ?? this.description,
      cost: cost ?? this.cost,
    );
  }

  @override
  List<Object?> get props => [service, description, cost];
}
