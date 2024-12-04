import 'dart:convert';

import 'package:equatable/equatable.dart';

class CostDetail extends Equatable {
  final int? value;
  final String? etd;
  final String? note;

  const CostDetail({this.value, this.etd, this.note});

  factory CostDetail.fromMap(Map<String, dynamic> data) => CostDetail(
        value: data['value'] as int?,
        etd: data['etd'] as String?,
        note: data['note'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'value': value,
        'etd': etd,
        'note': note,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CostDetail].
  factory CostDetail.fromJson(String data) {
    return CostDetail.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CostDetail] to a JSON string.
  String toJson() => json.encode(toMap());

  CostDetail copyWith({
    int? value,
    String? etd,
    String? note,
  }) {
    return CostDetail(
      value: value ?? this.value,
      etd: etd ?? this.etd,
      note: note ?? this.note,
    );
  }

  @override
  List<Object?> get props => [value, etd, note];
}
