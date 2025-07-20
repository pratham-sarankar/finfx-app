// Project imports:
import 'package:finfx/utils/api_error.dart';

class BrokerModel {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  BrokerModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BrokerModel.fromJson(Map<String, dynamic> json) {
    try {
      return BrokerModel(
        id: json['id'] as String,
        name: json['name'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );
    } catch (e) {
      throw ApiError.fromString('Failed to parse broker data');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() => name;
}
